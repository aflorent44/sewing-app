import 'package:mon_app_couture/features/fabrics/widgets/filters/fabric_filters.dart';
import 'package:mon_app_couture/models/fabric.dart';

class FabricsController {
  List<Fabric> allFabrics = [];

  List<Fabric> applyFilters(FabricFilters filters) {
    return allFabrics.where((fabric) {
      final matchesColour = filters.selectedColours.isEmpty
          ? true
          : fabric.colours!.any((c) => filters.selectedColours.contains(c));

      final matchesSeason = filters.selectedSeasons.isEmpty
          ? true
          : fabric.seasons!.any((s) => filters.selectedSeasons.contains(s));

      final matchesLength = fabric.quantity != null
          ? fabric.quantity! >= filters.minRequiredQuantity
          : false;

      final search = filters.searchTerm.toLowerCase();

      final matchesSearch = filters.searchTerm.isEmpty
          ? true
          : fabric.name.toLowerCase().contains(search) ||
                (fabric.description ?? '').toLowerCase().contains(search) ||
                (fabric.notes ?? '').toLowerCase().contains(search) ||
                (fabric.brand ?? '').toLowerCase().contains(search);

      return matchesColour && matchesSeason && matchesLength && matchesSearch;
    }).toList();
  }
}
