import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/enums/season.dart';

class SeasonFilter extends StatelessWidget {
  final Set<Season> selectedSeasons;
  final ValueChanged<Set<Season>> onSelectionChanged;

  const SeasonFilter({
    super.key,
    required this.selectedSeasons,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: Season.values.map((season) {
        final isSelected = selectedSeasons.contains(season);
        return FilterChip(
          label: Text(season.label),
          selected: isSelected,
          showCheckmark: false,
          onSelected: (bool selected) {
            final newSelectedSeasons = Set<Season>.from(selectedSeasons);
            if (selected) {
              newSelectedSeasons.add(season);
            } else {
              newSelectedSeasons.remove(season);
            }
            onSelectionChanged(newSelectedSeasons);
          },
        );
      }).toList(),
    );
  }
}
