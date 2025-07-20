import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/boolean_chip_filter.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // prend toute la largeur
        children: [
          KeywordFilter(
            typedString: filters.searchTerm,
            onChanged: (newTerm) {
              onFiltersChanged(filters.copyWith(searchTerm: newTerm));
            },
          ),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: Text('Favoris'),
                selected: filters.isFavorite == true,
                onSelected: (bool selected) {
                  onFiltersChanged(
                    filters.copyWith(isFavorite: selected ? true : null),
                  );
                },
              ),

              BooleanChipFilter(
                label: 'Chutes',
                isActive: filters.isARemnant == true,
                onChanged: (value) {
                  onFiltersChanged(
                    filters.copyWith(isARemnant: value ? true : null),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          SeasonFilter(
            selectedSeasons: filters.selectedSeasons,
            onSelectionChanged: (newSeasons) {
              onFiltersChanged(filters.copyWith(selectedSeasons: newSeasons));
            },
          ),
          const SizedBox(height: 12),
          ColourFilter(
            selectedColours: filters.selectedColours,
            onSelectionChanged: (newColours) {
              onFiltersChanged(filters.copyWith(selectedColours: newColours));
            },
          ),
          const SizedBox(height: 12),
          QuantityFilter(
            mininumQuantity: filters.minRequiredQuantity,
            onChanged: (newQuantity) {
              onFiltersChanged(
                filters.copyWith(minRequiredQuantity: newQuantity),
              );
            },
          ),
        ],
      ),
    );
  }
}
