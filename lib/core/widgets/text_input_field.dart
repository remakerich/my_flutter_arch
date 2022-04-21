import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.hint,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  final String hint;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: TextField(
        cursorColor: Colors.black,
        cursorWidth: 1,
        onChanged: onChanged,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: false,
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
