import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/season.dart';

class FabricFilters {
  String searchTerm;
  Set<Season> selectedSeasons;
  Set<Colour> selectedColours;
  double minRequiredQuantity;

  FabricFilters({
    this.searchTerm = '',
    Set<Season>? selectedSeasons,
    Set<Colour>? selectedColours,
    this.minRequiredQuantity = 0.0,
  }) : selectedSeasons = selectedSeasons ?? {},
       selectedColours = selectedColours ?? {};

  FabricFilters copyWith({
    String? searchTerm,
    Set<Season>? selectedSeasons,
    Set<Colour>? selectedColours,
    double? minRequiredQuantity,
  }) {
    return FabricFilters(
      searchTerm: searchTerm ?? this.searchTerm,
      selectedSeasons: selectedSeasons ?? this.selectedSeasons,
      selectedColours: selectedColours ?? this.selectedColours,
      minRequiredQuantity: minRequiredQuantity ?? this.minRequiredQuantity,
    );
  }
}
