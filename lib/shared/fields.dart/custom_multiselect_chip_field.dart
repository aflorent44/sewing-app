import 'package:flutter/material.dart';

class CustomMultiselectChipField<T extends Enum> extends StatelessWidget {
  final String label;
  final List<T> values;
  final List<T> selected;
  final ValueChanged<List<T>> onChanged;
  final String Function(T)? labelBuilder;
  final Widget Function(T)? chipBuilder;

  const CustomMultiselectChipField({
    super.key,
    required this.label,
    required this.values,
    required this.selected,
    required this.onChanged,
    this.labelBuilder,
    this.chipBuilder,
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
              alignment: WrapAlignment.center, // aligne les chips au centre
              spacing: 2,
              children: values.map((value) {
                final isSelected = selected.contains(value);
                return FilterChip(
                  label: chipBuilder != null
                      ? chipBuilder!(value)
                      : Text(
                          labelBuilder?.call(value) ?? value.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                  labelStyle: const TextStyle(fontSize: 10),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                  visualDensity: VisualDensity.comfortable,
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
          ),
        ],
      ),
    );
  }
}
