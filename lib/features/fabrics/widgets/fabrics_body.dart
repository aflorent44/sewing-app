import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/fabrics/widgets/fabric_tile.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/fabric_filters.dart';
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
        Expanded(child: _buildBody()) ,
        // Padding(
        //   padding: const EdgeInsets.all(6.0),
        //   child: ElevatedButton.icon(
        //     onPressed: () => openFabricForm(null),
        //     icon: Icon(Icons.add),
        //     label: Text("Ajouter un tissu"),
        //   ),
        // ),
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
      return GridView.count(
        crossAxisCount: 2, // 👉 3 cartes par ligne
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        padding: const EdgeInsets.all(2),
        childAspectRatio: 1/1.2, // 👉 Ajuste selon la forme de ta carte
        children: fabrics
            .map(
              (fabric) =>
                  FabricTile(fabric: fabric, openFabricForm: openFabricForm),
            )
            .toList(),
      );
    }
  }
}
