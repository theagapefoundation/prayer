import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/common/sheets/confirm_menu_form.dart';
import 'package:prayer/features/user/widgets/forms/user_image_form.dart';
import 'package:prayer/features/group/widgets/forms/membership_type_form.dart';
import 'package:prayer/features/common/widgets/forms/text_input_form.dart';
import 'package:prayer/features/common/widgets/forms/upload_progress_bar.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/repo/group_repository.dart';

class GroupFormScreen extends HookConsumerWidget {
  const GroupFormScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState(false);
    final initialValue = GoRouterState.of(context).extra as Group?;

    final onCreate = useCallback(() async {
      if (formKey.currentState?.saveAndValidate() == true) {
        try {
          loading.value = true;
          final form = formKey.currentState!.value;
          talker.debug("[Group] Creating: $form");
          if (form['banner'] == null) {
            loading.value = false;
            return GlobalSnackBar.show(context,
                message: S.of(context).errorNeedGroupBanner);
          }
          await GetIt.I<GroupRepository>().createGroup(
            name: form['name'],
            description: form['description'],
            membershipType: form['membershipType'],
            banner: form['banner'],
          );
          context.pop(true);
          mixpanel.track('Group Created');
          talker.good("[Group] Created");
        } catch (e, st) {
          talker.handle(e, st, "[Group] Failed to create");
          GlobalSnackBar.show(context, message: S.of(context).errorCreateGroup);
        } finally {
          loading.value = false;
        }
      }
    }, []);

    final onEdit = useCallback(() async {
      try {
        if (initialValue == null) {
          GlobalSnackBar.show(context, message: S.of(context).errorEditGroup);
          return;
        }
        if (formKey.currentState?.saveAndValidate() == true) {
          loading.value = true;
          final form = formKey.currentState!.value;
          talker.debug("[Group] Editing: $form");
          if (form['banner'] == null) {
            loading.value = false;
            return GlobalSnackBar.show(context,
                message: S.of(context).errorNeedGroupBanner);
          }
          await GetIt.I<GroupRepository>().updateGroup(
            groupId: initialValue.id,
            name: form['name'],
            description: form['description'],
            banner: form['banner'],
          );
          mixpanel.track('Group Edited');
          context.pop(true);
          talker.good("[Group] Edited");
          return ref.invalidate(groupNotifierProvider(initialValue.id));
        }
      } catch (e, st) {
        talker.handle(e, st, "[Group] Failed to edit");
        GlobalSnackBar.show(context, message: S.of(context).errorEditGroup);
      } finally {
        loading.value = false;
      }
    }, []);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: PlatformScaffold(
        backgroundColor: MyTheme.surface,
        appBar: PlatformAppBar(
          backgroundColor: MyTheme.surface,
          automaticallyImplyLeading: true,
          leading: NavigateBackButton(result: false),
          title: Text(S.of(context).createGroup),
          trailingActions: [
            Center(
              child: PrimaryTextButton(
                text: initialValue == null
                    ? S.of(context).create
                    : S.of(context).edit,
                onTap: initialValue == null ? onCreate : onEdit,
                loading: loading.value,
              ),
            ),
          ],
        ),
        body: FormBuilder(
          key: formKey,
          initialValue: initialValue == null
              ? {
                  'membershipType': 'open',
                }
              : initialValue.toJson(),
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
                  BannerImageForm(
                    aspectRatio: 0.5,
                    initialValue: initialValue?.banner,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        TextInputField(
                          name: 'name',
                          labelText: S.of(context).groupName,
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
                            if (value.startsWith(' ')) {
                              return "Name must not start with whitespace";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          S.of(context).errorNameLessThan30Characters,
                          style: const TextStyle(
                            color: MyTheme.outline,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: MyTheme.disabled),
                        const SizedBox(height: 10),
                        TextInputField(
                          name: 'description',
                          labelText: S.of(context).groupDescription,
                          maxLines: 10,
                          maxLength: 300,
                          counterText: '',
                          validator: (value) {
                            if ((value ?? "").trim() == '') {
                              return S.of(context).errorNeedGroupDescription;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          S.of(context).titleGroupDescription,
                          style: const TextStyle(
                            color: MyTheme.outline,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (initialValue != null) ...[
                          const Divider(color: MyTheme.disabled),
                          loading.value
                              ? PlatformCircularProgressIndicator()
                              : PrimaryTextButton(
                                  text: S.of(context).delete,
                                  onTap: () async {
                                    loading.value = true;
                                    if (await ConfirmMenuForm.show(
                                          context,
                                          title: S.of(context).deleteGroup,
                                          subtitle: S
                                              .of(context)
                                              .alertYouCannotUndoThisAction,
                                          description: S
                                              .of(context)
                                              .alertDeleteGroup
                                              .split(":")
                                              .toList(),
                                          icon: FontAwesomeIcons.lightTrash,
                                        ) ==
                                        true) {
                                      GetIt.I<GroupRepository>()
                                          .removeGroup(initialValue.id)
                                          .then((value) {
                                        Navigator.of(context)
                                            .popUntil(ModalRoute.withName('/'));
                                      }).catchError((_) {
                                        GlobalSnackBar.show(context,
                                            message:
                                                S.of(context).errorDeleteGroup);
                                      }).whenComplete(() {
                                        loading.value = false;
                                      });
                                    } else {
                                      loading.value = false;
                                    }
                                  },
                                  backgroundColor: Colors.red,
                                ),
                        ],
                        if (initialValue == null) ...[
                          const Divider(color: MyTheme.disabled),
                          const SizedBox(height: 10),
                          Text(
                            S.of(context).membershipType,
                            style: const TextStyle(
                              color: MyTheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            S.of(context).titleMembershipType,
                            style: const TextStyle(
                                color: MyTheme.placeholderText, fontSize: 12),
                          ),
                          const SizedBox(height: 10),
                          const MembershipTypeForm(),
                        ],
                        const SizedBox(height: 100),
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
