import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/corporate_prayer/widgets/group_corporate_prayers_screen.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class CorporatePrayerPicker extends HookWidget {
  const CorporatePrayerPicker({
    super.key,
    required this.groupId,
  });

  final String groupId;

  static Future<String?> show(
    BuildContext context, {
    required String groupId,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => CorporatePrayerPicker(
        groupId: groupId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pagingController =
        usePagingController<String?, String>(firstPageKey: null);

    return DraggableScrollableSheet(
      snap: true,
      snapSizes: [0.5, 1],
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          const SizedBox(height: 20),
          Text(
            t.corporatePrayer.form.picker.title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ShrinkingButton(
              onTap: () => Navigator.of(context).pop(null),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.lightGlobe,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      t.general.group,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: GroupCorporatePrayersScreen(
              noItemsFoundIndicatorBuilder: (p0) => const SizedBox(),
              groupId: groupId,
              pagingController: pagingController,
              scrollController: scrollController,
              onTap: (item) => Navigator.of(context).pop(item),
            ),
          ),
        ],
      ),
    );
  }
}
