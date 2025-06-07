import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  const TextComponent({
    super.key,
    this.labelField,
    this.controller,
    this.colorFont,
    this.hintText,
    this.maxLines = 1,
    this.validator,
  });
  final String? labelField;
  final TextEditingController? controller;
  final Color? colorFont;
  final String? hintText;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator ??
          (value) {
            if (value?.trim().isEmpty ?? true) {
              return 'This field is required';
            }
            return null;
          },
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelField,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
