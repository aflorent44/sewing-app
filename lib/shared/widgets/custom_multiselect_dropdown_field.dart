import 'package:flutter/material.dart';

class CustomMultiselectDropdownField<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final List<T> selected;
  final String Function(T) itemLabelBuilder;
  final void Function(List<T>) onChanged;


  const CustomMultiselectDropdownField({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.itemLabelBuilder,
    required this.onChanged,
  });

@override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          isExpanded: true,
          hint: const Text('Sélectionner...'),
          items: options.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabelBuilder(item)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null && !selected.contains(value)) {
              final updated = [...selected, value];
              onChanged(updated);
            }
          },
        ),
        Wrap(
          spacing: 8,
          children: selected.map((item) {
            return Chip(
              label: Text(itemLabelBuilder(item)),
              onDeleted: () {
                final updated = [...selected]..remove(item);
                onChanged(updated);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}