import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    Key? key,
    required this.hint,
    this.onChanged,
    this.controller,
    this.onSubmitted,
    this.isObscure = false,
  }) : super(key: key);

  final String hint;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isObscure;
  final Function(String)? onSubmitted;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: TextField(
        onSubmitted: onSubmitted,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        cursorWidth: 1,
        onChanged: onChanged,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 10),
          isCollapsed: true,
        ),
      ),
    );
  }
}
