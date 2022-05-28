import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool obscureText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _visibility = true;

  void toggleVisibility() {
    setState(() {
      _visibility = !_visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      obscureText: _visibility,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon:
                    Icon(_visibility ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  toggleVisibility();
                },
              )
            : null,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter your ${widget.hintText}";
        }
        return null;
      },
    );
  }
}
