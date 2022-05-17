import 'package:flutter/material.dart';

class EasterEgg extends StatelessWidget {
  const EasterEgg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 1,
      width: 1,
      child: CircularProgressIndicator(
        color: Colors.transparent,
      ),
    );
  }
}
