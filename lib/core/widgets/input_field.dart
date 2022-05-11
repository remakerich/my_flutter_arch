import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myarchapp/core/utils/ui.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    Key? key,
    required this.hint,
    this.onChanged,
    this.controller,
    this.onSubmitted,
    this.isObscure = false,
    this.validator,
    this.hasDefaultValidator = false,
    this.defaultValidatorErrorMessage = '',
    this.inputFormatters = const [],
  }) : super(key: key);

  final String hint;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isObscure;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final bool hasDefaultValidator;
  final String defaultValidatorErrorMessage;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppShapes.padding),
      child: TextFormField(
        onFieldSubmitted: onSubmitted,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        cursorWidth: 1,
        onChanged: onChanged,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: isObscure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        validator: hasDefaultValidator
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return defaultValidatorErrorMessage;
                }
                return null;
              }
            : validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.all(AppShapes.padding),
          hintText: hint,
          isDense: true,
          isCollapsed: true,
          errorStyle: TextStyle(
            color: Theme.of(context).errorColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(AppShapes.borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(AppShapes.borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(AppShapes.borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(AppShapes.borderRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(AppShapes.borderRadius),
          ),
          floatingLabelStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyText2?.color),
        ),
      ),
    );
  }
}
