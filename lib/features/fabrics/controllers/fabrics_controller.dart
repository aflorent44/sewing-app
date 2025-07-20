import 'package:mon_app_couture/features/fabrics/widgets/filters/fabric_filters.dart';
import 'package:mon_app_couture/features/fabrics/widgets/sorting/fabric_sorting.dart';
import 'package:mon_app_couture/features/fabrics/widgets/sorting/fabric_sorting_criterias.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:diacritic/diacritic.dart';

class FabricsController {
  List<Fabric> allFabrics = [];

  List<Fabric> getFilteredAndSortedFabrics({
    required FabricFilters filters,
    required FabricSorting sorting,
  }) {
    final filtered = _applyFilters(filters);
    return _applySorting(filtered, sorting);
  }

  List<Fabric> _applyFilters(FabricFilters filters) {
    final search = removeDiacritics(filters.searchTerm.toLowerCase());
    return allFabrics.where((fabric) {
      final matchesColour = filters.selectedColours.isEmpty
          ? true
          : (fabric.colours ?? []).any(
              (c) => filters.selectedColours.contains(c),
            );

      final matchesSeason = filters.selectedSeasons.isEmpty
          ? true
          : (fabric.seasons ?? []).any(
              (s) => filters.selectedSeasons.contains(s),
            );

      final matchesLength = fabric.quantity == null
          ? filters.minRequiredQuantity == 0.0
          : fabric.quantity! >= filters.minRequiredQuantity;

      final matchesFavorites = filters.isFavorite == true
          ? fabric.isFavorite == true
          : true;

      final matchesARemnant = filters.isARemnant == true
          ? fabric.isARemnant == true
          : true;

      final matchesSearch = search.isEmpty
          ? true
          : [
              fabric.name,
              fabric.description ?? '',
              fabric.brand ?? '',
              fabric.notes ?? '',
            ].any((field) {
              final cleanedField = removeDiacritics(field.toLowerCase().trim());
              return cleanedField.contains(search);
            });

      return matchesColour &&
          matchesSeason &&
          matchesLength &&
          matchesFavorites &&
          matchesARemnant &&
          matchesSearch;
    }).toList();
  }

  List<Fabric> _applySorting(List<Fabric> fabrics, FabricSorting sorting) {
    final sortedFabrics = [...fabrics];

    switch (sorting.criteria) {
      case FabricSortingCriterias.nameAsc:
        sortedFabrics.sort((a, b) => a.name.compareTo(b.name));
        break;
      case FabricSortingCriterias.nameDesc:
        sortedFabrics.sort((a, b) => b.name.compareTo(a.name));
        break;
      case FabricSortingCriterias.quantityAsc:
        sortedFabrics.sort(
          (a, b) => (a.quantity ?? 0).compareTo(b.quantity ?? 0),
        );
        break;
      case FabricSortingCriterias.quantityDesc:
        sortedFabrics.sort(
          (a, b) => (b.quantity ?? 0).compareTo(a.quantity ?? 0),
        );
        break;
      case null:
        break; // Pas de tri à appliquer
    }

    return sortedFabrics;
  }
}
