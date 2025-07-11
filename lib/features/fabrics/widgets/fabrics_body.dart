import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/colour_filter.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/fabric_filters.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/keyword_filter.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/quantity_filter.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/season_filter.dart';
import 'package:mon_app_couture/models/fabric.dart';

class FabricsBody extends StatelessWidget {
  final FabricFilters filters;
  final void Function(FabricFilters) onFiltersChanged;
  final List<Fabric> fabrics;
  final bool isLoading;
  final bool hasError;
  final void Function(Fabric?) openFabricForm;

  const FabricsBody({
    super.key,
    required this.filters,
    required this.onFiltersChanged,
    required this.fabrics,
    required this.isLoading,
    required this.hasError,
    required this.openFabricForm,
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
        Expanded(child: _buildBody()),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () => openFabricForm(null),
            icon: Icon(Icons.add),
            label: Text("Ajouter un tissu"),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (hasError) {
      return Center(child: Text('Une erreur est survenue 😢'));
    } else if (fabrics.isEmpty) {
      return Center(child: Text('Aucun tissu à afficher.'));
    } else {
      return ListView.builder(
        itemCount: fabrics.length,
        itemBuilder: (context, index) {
          final fabric = fabrics[index];
          return ListTile(
            title: Text(fabric.name),
            onTap: () => openFabricForm(fabric),
          );
        },
      );
    }
  }
}
