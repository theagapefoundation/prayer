import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/settings/reminders/models/local_reminder.dart';
import 'package:prayer/features/settings/reminders/widgets/local_reminder_card.dart';

import 'package:prayer/i18n/strings.g.dart';

class ReminderListScreen extends HookWidget {
  const ReminderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reminders = useValueListenable(
        Hive.box<LocalReminder>('local_reminders').listenable());
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: NavigateBackButton(),
        title: Text(t.general.reminders),
        cupertino: (context, platform) => CupertinoNavigationBarData(
            backgroundColor: Theme.of(context).colorScheme.background),
        trailingActions: [
          NavigateIconButton(
            icon: FontAwesomeIcons.alarmPlus,
            onPressed: () {
              if (reminders.length == 5) {
                GlobalSnackBar.show(context,
                    message: 'You can set up to 5 reminders');
                return;
              }
              context.push('/settings/reminders/form');
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              t.error.fullLocalReminders(max: 5),
              textAlign: TextAlign.center,
            ),
          ),
          ...reminders.values.toList().asMap().entries.map((entry) =>
              LocalReminderCard(reminderId: entry.key, reminder: entry.value)),
        ],
      ),
    );
  }
}
