import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/features/group/widgets/group_search_screen.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class GroupPicker extends HookWidget {
  const GroupPicker({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => GroupPicker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pagingController =
        usePagingController<String?, Group>(firstPageKey: null);
    return DraggableScrollableSheet(
      snap: true,
      snapSizes: [0.5, 1],
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          const SizedBox(height: 20),
          Text(
            t.group.form.picker.title,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ShrinkingButton(
              onTap: () => Navigator.of(context).pop(''),
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
                      t.general.community,
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
            child: GroupSearchScreen(
              pagingController: pagingController,
              uid: FirebaseAuth.instance.currentUser!.uid,
              noItemsFoundIndicatorBuilder: (p0) => SizedBox(),
              scrollController: scrollController,
              onTap: (item) => Navigator.of(context).pop(item),
            ),
          ),
        ],
      ),
    );
  }
}
