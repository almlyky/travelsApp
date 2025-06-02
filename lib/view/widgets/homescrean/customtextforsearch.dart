import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final icon;
  final String hint;
  final TextEditingController textInputControl;
  const CustomTextField({
    super.key,
    this.icon,
    required this.hint,
    required this.textInputControl,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textInputControl,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5),

        hintText: hint,
        prefixIcon: icon,
        border: const OutlineInputBorder(),
        filled: true, // لتفعيل تغيير الخلفية
        fillColor: Colors.grey[200], // لون الخلفية
      ),
    );
  }
}