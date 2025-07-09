import 'package:flutter/material.dart';

class CustomNumericField extends StatelessWidget {
  final String label;
  final String initialValue;
  final FormFieldSetter<String>? onSaved;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomNumericField({
    super.key,
    required this.label,
    required this.initialValue,
    this.onSaved,
    this.validator,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
