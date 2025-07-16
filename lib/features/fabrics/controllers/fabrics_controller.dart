import 'package:mon_app_couture/features/fabrics/widgets/filters/fabric_filters.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:diacritic/diacritic.dart';

class FabricsController {
  List<Fabric> allFabrics = [];

  List<Fabric> applyFilters(FabricFilters filters) {
    final search = removeDiacritics(filters.searchTerm.toLowerCase());
    print(search);
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

      final matchesSearch = search.isEmpty
          ? true
          : [
              fabric.name,
              fabric.description ?? '',
              fabric.brand ?? '',
              fabric.notes ?? '',
            ].any((field) {
              print(field);
              final cleanedField = removeDiacritics(field.toLowerCase().trim());
              print(cleanedField);
              return cleanedField.contains(search);
            });

      return matchesColour && matchesSeason && matchesLength && matchesSearch;
    }).toList();
  }
}
