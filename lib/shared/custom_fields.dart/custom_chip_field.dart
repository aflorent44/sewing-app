import 'package:flutter/material.dart';

class CustomChipField<T extends Enum> extends StatelessWidget {
  final String label;
  final List<T> values;
  final T selected;
  final ValueChanged<T> onChanged;
  final String Function(T)? labelBuilder;

  const CustomChipField({
    super.key,
    required this.label,
    required this.values,
    required this.selected,
    required this.onChanged,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            textAlign: TextAlign.start,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Wrap(
              spacing: 2,
              runSpacing: 3,
              children: values.map((value) {
                final isSelected = selected == value;
                return ChoiceChip(
                  label: Text(labelBuilder?.call(value) ?? value.toString()),
                  labelStyle: const TextStyle(fontSize: 12),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                  showCheckmark: false,
                  selected: isSelected,
                  onSelected: (bool selectedNow) {
                    if (selectedNow) {
                      onChanged(value);
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
