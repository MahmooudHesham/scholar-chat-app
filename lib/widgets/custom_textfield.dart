import 'package:flutter/material.dart';

class CustomTextFormfield extends StatelessWidget {
  CustomTextFormfield({
    super.key,
    this.hintText,
    this.onChange,
    this.obsecureText = false,
  });

  final String? hintText;
  Function(String)? onChange;
  bool? obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter Email and Password';
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
