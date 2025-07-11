import 'package:flutter/material.dart';

class KeywordFilter extends StatelessWidget {
  final String typedString;
  final ValueChanged<String> onChanged;

  const KeywordFilter({
    super.key,
    required this.typedString,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Rechercher par mot-clé'),
      onChanged: (value) => onChanged(value),
    );
  }
}
