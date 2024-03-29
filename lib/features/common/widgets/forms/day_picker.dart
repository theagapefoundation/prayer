import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class DayPicker extends HookWidget {
  const DayPicker({
    super.key,
    this.initialValue,
  });

  final List<int>? initialValue;

  static Future<List<int>?> show(
    BuildContext context, {
    List<int>? initialValue,
  }) {
    return showModalBottomSheet<List<int>>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => DayPicker(
        initialValue: initialValue,
      ),
    );
  }

  Widget _buildRow({
    required String title,
    void Function()? onTap,
    required bool value,
  }) {
    return ShrinkingButton(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IgnorePointer(
            child: Checkbox(
              value: value,
              onChanged: (value) => null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = useState(initialValue ?? <int>[]);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            t.general.reminder,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          ...[7, 1, 2, 3, 4, 5, 6]
              .map((index) => _buildRow(
                  title: Jiffy.now().startOf(Unit.week).add(days: index).EEEE,
                  value: state.value.indexOf(index) != -1,
                  onTap: () => state.value = state.value.indexOf(index) == -1
                      ? [...state.value, index]
                      : [...state.value..remove(index)]))
              .toList(),
          ShrinkingButton(
            onTap: () => context.pop([...state.value]),
            child: Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                t.general.done,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
