import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarchapp/core/utils/ui.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.loading = false,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColors.accent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.borderRadius),
        ),
      ),
      onPressed: loading ? null : onPressed,
      child: loading
          ? Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.transparent,
                  ),
                ),
                const CupertinoActivityIndicator(),
              ],
            )
          : Text(label),
    );
  }
}
