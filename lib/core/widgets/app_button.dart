import 'package:flutter/material.dart';
import 'package:myarchapp/core/utils/ui.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColors.accent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed:onPressed,
      child: Text(label),
    );
  }
}
