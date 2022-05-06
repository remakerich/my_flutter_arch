import 'package:flutter/material.dart';

class SmoothTransitionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SmoothTransitionAppBar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: Stack(
        children: [
          const SizedBox(
            height: 1,
            width: 1,
            child: CircularProgressIndicator(
              color: Colors.transparent,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
