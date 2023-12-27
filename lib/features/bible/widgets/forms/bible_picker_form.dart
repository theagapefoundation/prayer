import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/bible_books.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/bible/widgets/forms/bible_translation_picker.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class BiblePickerProvider extends ChangeNotifier {
  BibleBook? currentBook = null;
  int? currentChapter = null;
  BibleTranslation currentTranslation = BibleTranslation.preference();
  List<BibleVerse> _selected = [];
  List<BibleVerse> get selected => _selected;

  void setTranslation(BibleTranslation newTranslation) {
    currentTranslation = newTranslation;
    GetIt.I<SharedPreferences>()
        .setInt('bible_translations.preference', newTranslation.id);
    notifyListeners();
  }

  void setPage(BibleBook? newBook, int? newChapter) {
    currentBook = newBook;
    currentChapter = newChapter;
    notifyListeners();
  }

  void add(BibleVerse verse) {
    _selected.add(verse);
    notifyListeners();
  }

  void remove(BibleVerse verse) {
    _selected.removeWhere(
      (element) =>
          element.book == verse.book &&
          element.chapter == verse.chapter &&
          element.verse == verse.verse,
    );
    notifyListeners();
  }

  void set(List<BibleVerse> newIds) {
    _selected = newIds;
    notifyListeners();
  }

  void reset() {
    _selected.clear();
    notifyListeners();
  }
}

final biblePickerProvider =
    ChangeNotifierProvider((ref) => BiblePickerProvider());

class StickyActionBar extends ConsumerWidget {
  const StickyActionBar({
    super.key,
    required this.maxLength,
  });

  final int maxLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(biblePickerProvider).selected;
    return ShrinkingButton(
      onTap: () {
        context.pop([...ref.read(biblePickerProvider).selected]);
        ref.read(biblePickerProvider.notifier).reset();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MyTheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${S.of(context).done} (${selected.length}/$maxLength)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Text(
              selected
                  .map((e) =>
                      '${toLocaleBibleBook(context, e.book)} ${e.chapter}:${e.verse}')
                  .join(', '),
              style: TextStyle(fontSize: 10, color: MyTheme.placeholderText),
            ),
          ],
        ),
      ),
    );
  }
}

class BibleBookTile extends HookConsumerWidget {
  const BibleBookTile({
    super.key,
    required this.expanded,
    this.onExpanded,
    required this.title,
    required this.chapterCount,
    this.onTap,
    this.last = false,
  });

  final bool expanded;
  final void Function()? onExpanded;
  final String title;
  final int chapterCount;
  final void Function(int verse)? onTap;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useExpansionTileController();
    final mounted = useIsMounted();
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!expanded && mounted()) {
          controller.collapse();
        }
      });
      return () => null;
    }, [expanded]);

    return Padding(
      padding: EdgeInsets.only(bottom: last ? 200 : 0),
      child: Theme(
        data: Theme.of(context).copyWith(
            listTileTheme: ListTileTheme.of(context).copyWith(dense: true)),
        child: ExpansionTile(
          initiallyExpanded: expanded,
          childrenPadding: const EdgeInsets.only(bottom: 10),
          onExpansionChanged: (value) {
            if (value) {
              onExpanded?.call();
            }
          },
          controller: controller,
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
              itemCount: chapterCount,
              itemBuilder: (context, verseIndex) => ShrinkingButton(
                onTap: () {
                  onTap?.call(verseIndex);
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: MyTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text("${verseIndex + 1}"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BiblePicker {
  static SliverWoltModalSheetPage bookPage(
    BuildContext modalSheetContext, {
    required int maxLength,
    List<BibleVerse>? initialIds,
  }) {
    return SliverWoltModalSheetPage(
      topBarTitle: Text(
        S.of(modalSheetContext).bible,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      leadingNavBarWidget: Container(
        margin: const EdgeInsets.only(left: 20),
        child: UnconstrainedBox(
          child: Consumer(
            builder: (context, ref, _) {
              return PrimaryTextButton(
                text: S.of(modalSheetContext).cancel,
                onTap: () {
                  ref.read(biblePickerProvider.notifier).reset();
                  modalSheetContext.pop(null);
                },
              );
            },
          ),
        ),
      ),
      mainContentSlivers: [
        HookConsumer(
          builder: (context, ref, _) {
            final expanded = useValueListenable(bookNotifier);
            useEffect(() {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ref.read(biblePickerProvider.notifier).set(initialIds ?? []);
              });
              return () => null;
            }, []);
            return SliverList.builder(
              itemCount: bible_books.length,
              itemBuilder: (context, bookIndex) => BibleBookTile(
                expanded: expanded == bookIndex,
                title:
                    toLocaleBibleBook(context, bible_books[bookIndex]['key']) ??
                        '',
                chapterCount: bible_books[bookIndex]['page'] as int,
                onExpanded: () {
                  bookNotifier.value = bookIndex;
                },
                last: bible_books.length == bookIndex + 1,
                onTap: (verseIndex) {
                  ref.read(biblePickerProvider.notifier).setPage(
                        bible_books[bookIndex]['key'] as BibleBook,
                        verseIndex + 1,
                      );
                  pageNotifier.value = 1;
                },
              ),
            );
          },
        ),
      ],
      isTopBarLayerAlwaysVisible: true,
      stickyActionBar: StickyActionBar(maxLength: maxLength),
    );
  }

  static SliverWoltModalSheetPage versePage(
    BuildContext modalSheetContext, {
    required int maxLength,
    List<BibleVerse>? initialIds,
  }) {
    return SliverWoltModalSheetPage(
      leadingNavBarWidget: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final book = ref.watch(biblePickerProvider).currentBook;
                  final page = ref.watch(biblePickerProvider).currentChapter;
                  return ShrinkingButton(
                    onTap: () => pageNotifier.value = 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: MyTheme.surface,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        '${toLocaleBibleBook(context, book!)} $page',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 2),
              Consumer(
                builder: (context, ref, _) {
                  final translation =
                      ref.watch(biblePickerProvider).currentTranslation;
                  return ShrinkingButton(
                    onTap: () async {
                      final data =
                          await BibleTranslationPicker.show(modalSheetContext);
                      if (data != null) {
                        ref.read(biblePickerProvider).setTranslation(data);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: MyTheme.surface,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        translation.abbreviation,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      mainContentSlivers: [
        HookConsumer(
          builder: (context, ref, _) {
            final book = ref.watch(biblePickerProvider).currentBook;
            final chapter = ref.watch(biblePickerProvider).currentChapter;
            final translation =
                ref.watch(biblePickerProvider).currentTranslation;
            final snapshot = useFuture(
              useMemoized(
                  () => dio.get(
                      '/v1/bibles/books/${bible_books.firstWhere((element) => element['key'] == book)['name']}/chapters/$chapter',
                      queryParameters: {'translationId': translation.id}),
                  [translation.id]),
              preserveState: false,
            );
            final data = snapshot.data?.data['data'];
            if (data == null) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            return SliverList.builder(
              itemCount: data == null ? 10 : (data as List<dynamic>).length,
              itemBuilder: (context, index) => ShrinkingButton(
                onTap: () {
                  final selected = ref.read(biblePickerProvider).selected;
                  if (selected.length >= maxLength) {
                    return;
                  }
                  final current = BibleVerse(
                    id: snapshot.data?.data['data'][index]['id'],
                    book: book!,
                    chapter: chapter!,
                    verse: index + 1,
                    value: snapshot.data?.data['data'][index]['value'],
                    verseId: snapshot.data?.data['data'][index]['verse_id'],
                    translation: translation,
                  );
                  if (selected.indexWhere((element) =>
                          element.book == book &&
                          element.chapter == chapter &&
                          element.verse == index + 1) ==
                      -1) {
                    ref.read(biblePickerProvider.notifier).add(current);
                  } else {
                    ref.read(biblePickerProvider.notifier).remove(current);
                  }
                },
                child: Consumer(
                  builder: (context, ref, _) {
                    final selected = ref.watch(biblePickerProvider).selected;
                    final chosen = selected.indexWhere((element) =>
                            element.book == book &&
                            element.chapter == chapter &&
                            element.verse == index + 1) !=
                        -1;
                    return Container(
                      padding: EdgeInsets.fromLTRB(
                          10,
                          5,
                          10,
                          5 +
                              (index + 1 == (data as List<dynamic>).length
                                  ? 100
                                  : 0)),
                      child: RichText(
                        text: TextSpan(
                          text: '${index + 1}. ',
                          style: TextStyle(color: MyTheme.placeholderText),
                          children: [
                            TextSpan(
                              text:
                                  '${snapshot.data?.data['data'][index]['value']}',
                              style: TextStyle(
                                decorationColor: MyTheme.onPrimary,
                                fontWeight: FontWeight.w300,
                                decoration:
                                    chosen ? TextDecoration.underline : null,
                                decorationStyle: TextDecorationStyle.dashed,
                                color: (selected.length == maxLength && !chosen)
                                    ? MyTheme.disabled
                                    : MyTheme.onPrimary,
                                fontSize: 15,
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
      isTopBarLayerAlwaysVisible: true,
      stickyActionBar: StickyActionBar(maxLength: maxLength),
    );
  }

  static final pageNotifier = ValueNotifier<int>(0);
  static final bookNotifier = ValueNotifier<int>(-1);

  static Future<List<BibleVerse>?> show(BuildContext context,
      {int maxLength = 5, List<BibleVerse>? initialIds}) {
    pageNotifier.value = 0;
    bookNotifier.value = 0;
    return WoltModalSheet.show<List<BibleVerse>>(
      pageIndexNotifier: pageNotifier,
      context: context,
      pageListBuilder: (modalSheetContext) => [
        bookPage(
          modalSheetContext,
          maxLength: maxLength,
          initialIds: initialIds,
        ),
        versePage(
          modalSheetContext,
          maxLength: maxLength,
          initialIds: initialIds,
        ),
      ],
      onModalDismissedWithBarrierTap: () {
        pageNotifier.value = 0;
        Navigator.of(context).pop(null);
      },
      useSafeArea: true,
      modalTypeBuilder: (_) => WoltModalType.bottomSheet,
      minPageHeight: 1.0,
      maxPageHeight: 1.0,
    );
  }
}