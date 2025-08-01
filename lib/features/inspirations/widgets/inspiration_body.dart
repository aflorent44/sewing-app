import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/inspirations/widgets/inspiration_tile.dart';
import 'package:mon_app_couture/models/inspiration.dart';

class InspirationsBody extends StatelessWidget {
  final List<Inspiration> inspirations;
  final bool isLoading;
  final bool hasError;
  final void Function(Inspiration?) openForm;

  const InspirationsBody({
    super.key,
    required this.inspirations,
    required this.isLoading,
    required this.hasError,
    required this.openForm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: _buildBody())]);
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (hasError) {
      return Center(child: Text('Une erreur est survenue 😢'));
    } else if (inspirations.isEmpty) {
      return Center(child: Text('Aucune inspiration à afficher.'));
    } else {
      return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        padding: const EdgeInsets.all(2),
        childAspectRatio: 1 / 1.2, // 👉 Ajuste selon la forme de ta carte
        children: inspirations
            .map(
              (element) =>
                  InspirationTile(inspiration: element, openForm: openForm),
            )
            .toList(),
      );
    }
  }
}
