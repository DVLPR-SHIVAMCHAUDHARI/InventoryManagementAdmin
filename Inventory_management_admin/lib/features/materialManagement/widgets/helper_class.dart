import 'package:flutter/material.dart';

Widget numField(
  TextEditingController controller,
  String label, {
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget dropdownField(
  String label,
  List<String> items,
  String? value,
  Function(String?) onChanged, {
  String? Function(String?)? validator,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    items: items
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList(),
    onChanged: onChanged,
  );
}

String? requiredValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "This field is required";
  }
  return null;
}

String? requiredNumberValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "This field is required";
  }

  if (int.tryParse(value) == null) {
    return "Enter a valid number";
  }

  return null;
}

Widget textField(
  TextEditingController controller,
  String label, {
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}
