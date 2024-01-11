import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/features/corporate_prayer/widgets/forms/corporate_prayer_picker.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/corporate_prayer/models/corporate_prayer/corporate_prayer_model.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CorporatePrayerForm extends HookWidget {
  const CorporatePrayerForm({
    super.key,
    required this.groupId,
    this.onChange,
  });

  final String groupId;
  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'corporateId',
      builder: (FormFieldState<String> field) => CorporatePrayerFormInner(
        groupId: groupId,
        corporateId: field.value,
        onChange: (prayerId) {
          field.didChange(prayerId);
          onChange?.call(prayerId);
        },
      ),
    );
  }
}

class CorporatePrayerFormInner extends HookWidget {
  const CorporatePrayerFormInner({
    super.key,
    required this.groupId,
    this.corporateId,
    this.onChange,
  });

  final String groupId;
  final String? corporateId;
  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    final fetchFn = useMemoized(
        () => corporateId == null
            ? null
            : GetIt.I<PrayerRepository>().fetchCorporatePrayer(corporateId!),
        [corporateId]);
    final snapshot =
        useFuture(fetchFn, initialData: CorporatePrayer.placeholder);

    useEffect(() {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data == null) {
        onChange?.call(null);
      }
      return () => null;
    }, [snapshot]);

    return Skeletonizer(
      enabled: snapshot.connectionState == ConnectionState.waiting,
      child: ShrinkingButton(
        onTap: () async {
          final prayerId = await CorporatePrayerPicker.show(
            context,
            groupId: groupId,
          );
          onChange?.call(prayerId);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(
                corporateId == null
                    ? t.general.group
                    : snapshot.data?.title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                maxLines: 1,
              ),
              const SizedBox(width: 5),
              FaIcon(
                FontAwesomeIcons.chevronDown,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
