import 'package:flutter/material.dart';
import 'package:streamly/widgets/custom_text_field.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;

  const CustomField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      obscureText: obscureText,
    );
  }
}
