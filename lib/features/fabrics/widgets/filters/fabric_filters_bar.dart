import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/fabric_filters.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/keyword_filter.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/season_filter.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/colour_filter.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/quantity_filter.dart';

class FabricFiltersBar extends StatelessWidget {
  final FabricFilters filters;
  final void Function(FabricFilters) onFiltersChanged;

  const FabricFiltersBar({
    super.key,
    required this.filters,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeywordFilter(
          typedString: filters.searchTerm,
          onChanged: (newTerm) {
            onFiltersChanged(filters.copyWith(searchTerm: newTerm));
          },
        ),
        SeasonFilter(
          selectedSeasons: filters.selectedSeasons,
          onSelectionChanged: (newSeasons) {
            onFiltersChanged(filters.copyWith(selectedSeasons: newSeasons));
          },
        ),
        ColourFilter(
          selectedColours: filters.selectedColours,
          onSelectionChanged: (newColours) {
            onFiltersChanged(filters.copyWith(selectedColours: newColours));
          },
        ),
        QuantityFilter(
          mininumQuantity: filters.minRequiredQuantity,
          onChanged: (newQuantity) {
            onFiltersChanged(
              filters.copyWith(minRequiredQuantity: newQuantity),
            );
          },
        ),
      ],
    );
  }
}
