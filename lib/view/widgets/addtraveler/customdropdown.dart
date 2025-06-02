import 'package:flutter/material.dart';
import 'package:travelapp2/controller/travelercontroller.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.travelercontroller,
      required this.item,
      required this.value,
      required this.hint,
      required this.onChanged});
  final Function(String?) onChanged;
  final Travelercontroller travelercontroller;
  final List<String> item;
  final String value;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: item
          .map((nationality) =>
              DropdownMenuItem(value: nationality, child: Text(nationality)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 233, 234, 237),
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        labelText: hint,
      ),
    );
  }
}
