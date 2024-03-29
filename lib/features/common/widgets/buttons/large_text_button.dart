import 'package:flutter/material.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class LargeTextButton extends StatelessWidget {
  const LargeTextButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.destructive = false,
  });

  final double? width;
  final String text;
  final bool destructive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: destructive
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: destructive
                ? Theme.of(context).colorScheme.onError
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
