import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/fabrics/widgets/sorting/fabric_sorting.dart';
import 'package:mon_app_couture/features/fabrics/widgets/sorting/fabric_sorting_criterias.dart';

class FabricSortingBar extends StatelessWidget {
  final FabricSorting sorting;
  final void Function(FabricSorting) onSortingChanged;

  const FabricSortingBar({super.key, required this.sorting, required this.onSortingChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownButton<FabricSortingCriterias>(
        value: sorting.criteria,
        hint: Text('Trier par'),
        onChanged: (FabricSortingCriterias? newOption) {
          onSortingChanged(FabricSorting(criteria: newOption));
        },
        items: FabricSortingCriterias.values.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(_sortOptionLabel(option)),
          );
        }).toList(),
      ),
    );
  }

  String _sortOptionLabel(FabricSortingCriterias criteria) {
    switch (criteria) {
      case FabricSortingCriterias.nameAsc:
        return 'Nom A-Z';
      case FabricSortingCriterias.nameDesc:
        return 'Nom Z-A';
      case FabricSortingCriterias.quantityAsc:
        return 'Quantité croissante';
      case FabricSortingCriterias.quantityDesc:
        return 'Quantité décroissante';
    }
  }

}
