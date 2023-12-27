import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/corporate_prayer/corporate_prayer_model.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/corporate_prayer/widgets/forms/duration_picker_form.dart';
import 'package:prayer/features/corporate_prayer/widgets/forms/reminder_form.dart';
import 'package:prayer/features/common/widgets/forms/text_input_form.dart';
import 'package:prayer/features/common/widgets/forms/upload_progress_bar.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/repo/prayer_repository.dart';

class CorporatePrayerForm extends HookWidget {
  const CorporatePrayerForm({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState(false);
    final prayers = useState(1);
    final initialValue = GoRouterState.of(context).extra as CorporatePrayer?;

    final onClick = useCallback(() {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        final form = formKey.currentState!.value;
        talker.debug(initialValue == null
            ? "[CorporatePrayer] Creating: $form"
            : "[CorporatePrayer] Updating: $form");
        loading.value = false;
        GetIt.I<PrayerRepository>()
            .createOrUpdateCorporatePrayer(
          corporateId: initialValue?.id,
          groupId: groupId,
          title: form['title'],
          description: form['description'],
          reminderDays: form['reminderActivated'] == true
              ? List<int>.from(jsonDecode(form['reminder']))
              : null,
          reminderText:
              form['reminderActivated'] == true ? form['reminderText'] : null,
          reminderTime:
              form['reminderActivated'] == true ? form['reminderTime'] : null,
          prayers: form.entries
              .where((element) =>
                  element.key.startsWith('prayers.') && element.value != null)
              .map((e) => e.value as String)
              .toList(),
          startedAt: form['startedAt'] == null
              ? null
              : (form['startedAt'] as Jiffy).dateTime,
          endedAt: form['endedAt'] == null
              ? null
              : (form['endedAt'] as Jiffy).dateTime,
        )
            .then((value) {
          context.pop(true);
          mixpanel.track(
              'Corproate Prayer ${initialValue == null ? 'Created' : 'Updated'}');
          talker.good(
              "[CorporatePrayer] ${initialValue == null ? 'Created' : 'Updated'}");
        }).catchError((e, st) {
          talker.handle(e, st,
              "[CorporatePrayer] Failed to ${initialValue == null ? 'create' : 'update'}");
          GlobalSnackBar.show(context,
              message: "Failed to create a corporate prayer");
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }, []);

    final handleInitialValue = useCallback((CorporatePrayer prayer) {
      final data = prayer.toJson();
      prayer.prayers?.asMap().forEach((index, element) {
        data['prayers.$index'] = element;
      });
      prayers.value = prayer.prayers?.length ?? 1;
      if (prayer.startedAt != null) {
        data['startedAt'] =
            Jiffy.parseFromDateTime(prayer.startedAt!.toLocal());
      }
      if (prayer.endedAt != null) {
        data['endedAt'] = Jiffy.parseFromDateTime(prayer.endedAt!.toLocal());
      }
      if (prayer.reminder != null) {
        data['reminderActivated'] = true;
        data['reminderTime'] = prayer.reminder!.time;
        data['reminder'] = jsonEncode(prayer.reminder!.days);
        data['reminderText'] = prayer.reminder!.value;
      }
      return data;
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: PlatformScaffold(
        backgroundColor: MyTheme.surface,
        appBar: PlatformAppBar(
          backgroundColor: MyTheme.surface,
          automaticallyImplyLeading: true,
          leading: NavigateBackButton(result: false),
          trailingActions: [
            Center(
              child: PrimaryTextButton(
                text: initialValue == null ? "Post" : "Edit",
                onTap: onClick,
                loading: loading.value,
              ),
            ),
          ],
        ),
        body: FormBuilder(
          key: formKey,
          initialValue:
              initialValue == null ? {} : handleInitialValue(initialValue),
          child: Stack(
            children: [
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: UploadProgressBar(),
              ),
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          S.of(context).bibleCorporatePrayerScreenVerse,
                          style: const TextStyle(
                            color: MyTheme.outline,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Center(
                          child: Text(
                            S.of(context).bibleCorporatePrayerScreenVerseBook,
                            style: const TextStyle(
                              color: MyTheme.outline,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          name: 'title',
                          labelText: S.of(context).title,
                          maxLines: 1,
                          maxLength: 30,
                          validator: (value) {
                            if (value == null || value.trim() == '') {
                              return S
                                  .of(context)
                                  .errorCorporatePrayerMustNotEmpty;
                            }
                            if (value.contains('@') || value.contains('#')) {
                              return S
                                  .of(context)
                                  .errorCorporatePrayerHasSpecialCharacters;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          name: 'description',
                          labelText: S.of(context).description,
                          maxLines: 5,
                          maxLength: 300,
                          counterText: '',
                          validator: (value) {
                            if ((value ?? "").trim() == '') {
                              return S
                                  .of(context)
                                  .errorNeedCorporatePrayerDescription;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: MyTheme.outline),
                        const SizedBox(height: 10),
                        ReminderDatePickerForm(
                          formKey: formKey,
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: MyTheme.outline),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: DurationPickerForm(),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          S.of(context).corporatePrayerReminderMesasge,
                          style: const TextStyle(
                            color: MyTheme.outline,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: MyTheme.outline),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              S.of(context).prayers,
                              style: const TextStyle(
                                color: MyTheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            ShrinkingButton(
                              onTap: () {
                                if (prayers.value < 2) {
                                  return;
                                }
                                prayers.value = prayers.value - 1;
                                formKey.currentState
                                    ?.fields['prayers.${prayers.value}']
                                    ?.didChange(null);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: prayers.value < 2
                                      ? MyTheme.disabled
                                      : MyTheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.minus,
                                  size: 15,
                                  color: MyTheme.onPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ShrinkingButton(
                              onTap: () {
                                prayers.value =
                                    prayers.value > 9 ? 10 : prayers.value + 1;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: prayers.value > 9
                                      ? MyTheme.disabled
                                      : MyTheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  size: 15,
                                  color: MyTheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(
                          prayers.value,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: TextInputField(
                              name: 'prayers.${index}',
                              labelText: '${S.of(context).prayer} ${index + 1}',
                              maxLines: 5,
                              maxLength: 200,
                              counterText: '',
                              validator: (value) {
                                if ((value ?? "").trim() == '') {
                                  return S
                                      .of(context)
                                      .errorCorporatePrayerNeedPrayers;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}