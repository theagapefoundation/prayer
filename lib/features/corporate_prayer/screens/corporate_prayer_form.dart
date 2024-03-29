import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/corporate_prayer/models/corporate_prayer/corporate_prayer_model.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/corporate_prayer/widgets/forms/duration_picker_form.dart';
import 'package:prayer/features/corporate_prayer/widgets/forms/reminder_form.dart';
import 'package:prayer/features/common/widgets/forms/text_input_form.dart';
import 'package:prayer/features/common/widgets/forms/upload_progress_bar.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/repo/prayer_repository.dart';

class CorporatePrayerForm extends StatefulWidget {
  const CorporatePrayerForm({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  State<CorporatePrayerForm> createState() => _CorporatePrayerFormState();
}

class _CorporatePrayerFormState extends State<CorporatePrayerForm> {
  final formKey = GlobalKey<FormBuilderState>();
  final focusNodes = List.generate(10, (index) => FocusNode());

  bool _loading = false;
  int _prayers = 1;

  @override
  void dispose() {
    focusNodes.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  Widget _buildIcon({
    required IconData icon,
    bool disabled = false,
    void Function()? onTap,
  }) {
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: disabled
              ? Theme.of(context).disabledColor
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: FaIcon(
          icon,
          size: 15,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  Future<void> onClick() async {
    if (formKey.currentState?.saveAndValidate() == true) {
      setState(() {
        _loading = true;
      });
      final form = formKey.currentState!.value;
      final initialValue = GoRouterState.of(context).extra as CorporatePrayer?;
      talker.debug(initialValue == null
          ? "[CorporatePrayer] Creating: $form"
          : "[CorporatePrayer] Updating: $form");
      setState(() {
        _loading = false;
      });
      try {
        final prayers = form.entries
            .where((element) =>
                element.key.startsWith('prayers.') && element.value != null)
            .map((e) => e.value as String)
            .where((element) => element.trim() != '')
            .toList();
        if (prayers.length < 1 || prayers[0].trim() == '') {
          GlobalSnackBar.show(context,
              message: t.error.corporatePrayerNeedPrayers);
          return;
        }
        final newCorporateId =
            await GetIt.I<PrayerRepository>().createOrUpdateCorporatePrayer(
          corporateId: initialValue?.id,
          groupId: widget.groupId,
          title: form['title'],
          description: form['description'],
          reminderDays: form['reminderActivated'] == true
              ? List<int>.from(jsonDecode(form['reminder']))
              : null,
          reminderText:
              form['reminderActivated'] == true ? form['reminderText'] : null,
          reminderTime:
              form['reminderActivated'] == true ? form['reminderTime'] : null,
          prayers: prayers,
          startedAt: form['startedAt'] == null
              ? null
              : (form['startedAt'] as Jiffy).dateTime,
          endedAt: form['endedAt'] == null
              ? null
              : (form['endedAt'] as Jiffy).dateTime,
        );
        context.pop(true);
        if (initialValue == null) {
          context.push('/prayers/corporate/$newCorporateId');
        }
        mixpanel.track(
            'Corproate Prayer ${initialValue == null ? 'Created' : 'Updated'}');
        talker.good(
            "[CorporatePrayer] ${initialValue == null ? 'Created' : 'Updated'}");
      } catch (e, st) {
        talker.handle(e, st,
            "[CorporatePrayer] Failed to ${initialValue == null ? 'create' : 'update'}");
        GlobalSnackBar.show(context, message: t.error.unknown);
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Map<String, dynamic> handleInitialValue(CorporatePrayer prayer) {
    final data = prayer.toJson();
    prayer.prayers?.asMap().forEach((index, element) {
      data['prayers.$index'] = element;
    });
    setState(() {
      _prayers = prayer.prayers?.length ?? 1;
    });
    if (prayer.startedAt != null) {
      data['startedAt'] = Jiffy.parseFromDateTime(prayer.startedAt!.toLocal());
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
  }

  @override
  Widget build(BuildContext context) {
    final initialValue = GoRouterState.of(context).extra as CorporatePrayer?;

    return KeyboardDismissOnTap(
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          cupertino: (context, platform) => CupertinoNavigationBarData(
              backgroundColor: Theme.of(context).colorScheme.background),
          automaticallyImplyLeading: true,
          leading: NavigateBackButton(result: false),
          trailingActions: [
            Center(
              child: PrimaryTextButton(
                text: initialValue == null ? "Post" : "Edit",
                onTap: onClick,
                loading: _loading,
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
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          t.corporatePrayer.form.main.bible.passage,
                          style: Theme.of(context).textTheme.labelMedium,
                          textAlign: TextAlign.center,
                        ),
                        Center(
                          child: Text(
                            t.corporatePrayer.form.main.bible.verse,
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          name: 'title',
                          labelText: t.general.title,
                          maxLines: 1,
                          maxLength: 30,
                          validator: (value) {
                            if (value == null || value.trim() == '') {
                              return t.error.corporatePrayerMustNotEmpty;
                            }
                            if (value.contains('@') || value.contains('#')) {
                              return t
                                  .error.corporatePrayerHasSpecialCharacters;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          name: 'description',
                          labelText: t.general.description,
                          maxLines: 5,
                          maxLength: 300,
                          counterText: '',
                          validator: (value) {
                            if ((value ?? "").trim() == '') {
                              return t.error.needCorporatePrayerDescription;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        ReminderDatePickerForm(
                          formKey: formKey,
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: DurationPickerForm(),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          t.corporatePrayer.form.main.duration.description,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Text(
                          t.general.prayers,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(
                          10,
                          (index) => Visibility(
                            visible: index < _prayers,
                            maintainState: true,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: TextInputField(
                                name: 'prayers.${index}',
                                focusNode: focusNodes[index],
                                scrollPadding:
                                    const EdgeInsets.only(bottom: 220),
                                labelText: '${t.general.prayer} ${index + 1}',
                                maxLines: 5,
                                maxLength: 200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildIcon(
                              icon: FontAwesomeIcons.minus,
                              disabled: _prayers < 2,
                              onTap: () {
                                if (_prayers < 2) {
                                  return;
                                }
                                formKey.currentState
                                    ?.fields['prayers.${_prayers - 1}']
                                    ?.didChange(null);
                                setState(() {
                                  _prayers = _prayers - 1;
                                });
                                focusNodes[_prayers - 1].requestFocus();
                              },
                            ),
                            const SizedBox(width: 10),
                            _buildIcon(
                              icon: FontAwesomeIcons.plus,
                              disabled: _prayers > 9,
                              onTap: () {
                                final value = _prayers;
                                setState(() {
                                  _prayers = value > 9 ? 10 : value + 1;
                                });
                                focusNodes[value].requestFocus();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: UploadProgressBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
