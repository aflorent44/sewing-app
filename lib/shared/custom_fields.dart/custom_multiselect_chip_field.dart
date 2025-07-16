import 'package:flutter/material.dart';

class CustomMultiselectChipField<T extends Enum> extends StatelessWidget {
  final String label;
  final List<T> values;
  final List<T> selected;
  final ValueChanged<List<T>> onChanged;
  final String Function(T)? labelBuilder;

  const CustomMultiselectChipField({
    super.key,
    required this.label,
    required this.values,
    required this.selected,
    required this.onChanged,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 2,
          runSpacing: 3,
          children: values.map((value) {
            final isSelected = selected.contains(value);
            return FilterChip(
              label: Text(labelBuilder?.call(value) ?? value.toString()),
              showCheckmark: false,
              selected: isSelected,
              onSelected: (bool selectedNow) {
                final updated = [...selected];
                if (selectedNow) {
                  updated.add(value);
                } else {
                  updated.remove(value);
                }
                onChanged(updated);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
