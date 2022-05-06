import 'package:flutter/material.dart';
import 'package:myarchapp/core/utils/ui.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label),
      style: TextButton.styleFrom(
        primary: AppColors.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.borderRadius),
        ),
      ),
    );
  }
}
