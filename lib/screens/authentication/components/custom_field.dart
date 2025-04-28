import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 52,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withAlpha((0.2 * 255).round()),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: GoogleFonts.prociono(
          fontSize: 16,
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none, // remove underline
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: "Jakarta",
            color: Colors.black.withAlpha((0.4 * 255).round()),
          ),
        ),
        keyboardType: keyboardType,
        autocorrect: false,
      ),
    );
  }
}
