import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/enums/colour.dart';

class ColourFilter extends StatelessWidget {
  final Set<Colour> selectedColours;
  final ValueChanged<Set<Colour>> onSelectionChanged;

  const ColourFilter({
    super.key,
    required this.selectedColours,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: Colour.values.map((colour) {
        final isSelected = selectedColours.contains(colour);
        return FilterChip(
          label: _colorCircle(colour),
          selected: isSelected,
          showCheckmark: false,
          onSelected: (bool selected) {
            final newSelectedColours = Set<Colour>.from(selectedColours);
            if (selected) {
              newSelectedColours.add(colour);
            } else {
              newSelectedColours.remove(colour);
            }
            onSelectionChanged(newSelectedColours);
          },
        );
      }).toList(),
    );
  }

  Widget _colorCircle(Colour colour) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: mapColourToColor(colour),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
    );
  }
}
