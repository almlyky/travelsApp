import 'package:flutter/material.dart';

class CustomTextfild extends StatefulWidget {
  const CustomTextfild({
    super.key,
    required this.controller,
    required this.hintext,
    this.icon,
    required this.validate,
    required this.obscureText,
    required this.prefixIcon,
  });

  final TextEditingController controller;
  final String hintext;
  final icon;
  final String? Function(String?) validate;
  final bool obscureText;
  final bool prefixIcon;

  @override
  State<CustomTextfild> createState() => _CustomTextfildState();
}

class _CustomTextfildState extends State<CustomTextfild> {
  bool? visible;
  @override
  void initState() {
    super.initState();
    visible = widget.obscureText;
  }

  void onPressed() {
    visible = !visible!;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validate,
      controller: widget.controller,
      obscureText: visible!,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 233, 234, 237),
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        prefixIcon: widget.prefixIcon ? Icon(widget.icon) : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(visible! ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    onPressed();
                  });
                },
              )
            : null,
        hintText: widget.hintext,
      ),
    );
  }
}
