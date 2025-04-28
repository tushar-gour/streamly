import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;

  @override
  State<CustomPasswordField> createState() => CustomPasswordFieldState();
}

class CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = true;

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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "Jakarta",
                color: Colors.black,
              ),
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none, // remove underline
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: "Jakarta",
                  color: Colors.black.withAlpha((0.4 * 255).round()),
                ),
              ),
              keyboardType: widget.keyboardType,
              obscureText: obscureText,
              autocorrect: false,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
            ),
          )
        ],
      ),
    );
  }
}
