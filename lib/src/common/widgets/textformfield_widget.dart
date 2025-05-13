import 'package:event_app/src/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorMsg,
    this.isObscure,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? errorMsg;
  final bool? isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure ?? false,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        hintText: hintText ?? AppStrings.emptyString,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMsg ?? AppStrings.emptyString;
        } else {
          return null;
        }
      },
    );
  }
}
