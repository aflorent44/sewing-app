import 'package:mon_app_couture/features/fabrics/widgets/sorting/fabric_sorting_criterias.dart';

class FabricSorting {
  final FabricSortingCriterias? criteria;

  FabricSorting({this.criteria});

  FabricSorting copyWith({FabricSortingCriterias? criteria}) =>
      FabricSorting(criteria: criteria ?? this.criteria);
}
