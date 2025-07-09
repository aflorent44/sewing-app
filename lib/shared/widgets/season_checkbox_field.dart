import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/enums/season.dart';

class SeasonCheckboxField extends StatelessWidget {
  final List<Season> selectedSeasons;
  final Function(List<Season>) onChanged;

  const SeasonCheckboxField({
    super.key,
    required this.selectedSeasons,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: Season.values.map((season) {
        final isSelected = selectedSeasons.contains(season);
        return CheckboxListTile(
          title: Text(season.label), 
          value: isSelected,
          onChanged: (bool? checked) {
            final newList = [...selectedSeasons];
            if (checked == true) {
              newList.add(season);
            } else {
              newList.remove(season);
            }
            onChanged(newList);
          },
        );
      }).toList(),
    );
  }
}

