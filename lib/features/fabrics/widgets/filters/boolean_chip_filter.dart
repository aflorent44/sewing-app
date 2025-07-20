import 'package:flutter/material.dart';

class BooleanChipFilter extends StatelessWidget {
  final String label;
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const BooleanChipFilter({
    super.key,
    required this.label,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isActive,
      onSelected: (bool selected) {
        print(selected);
        onChanged(selected); // selected = true ou false
      },
    );
  }
}
