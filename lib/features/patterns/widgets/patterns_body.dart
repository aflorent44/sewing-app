import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/patterns/widgets/pattern_tile.dart';
import 'package:mon_app_couture/models/pattern_model.dart';

class PatternsBody extends StatelessWidget {
  final List<PatternModel> patterns;
  final bool isLoading;
  final bool hasError;
  final void Function(PatternModel?) openPatternForm;

  const PatternsBody({
    super.key,
    required this.patterns,
    required this.isLoading,
    required this.hasError,
    required this.openPatternForm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (hasError) {
      return Center(child: Text('Une erreur est survenue 😢'));
    } else if (patterns.isEmpty) {
      return Center(child: Text('Aucun patron à afficher.'));
    } else {
      return GridView.count(
        crossAxisCount: 2, 
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        padding: const EdgeInsets.all(2),
        childAspectRatio: 1/1.2, // 👉 Ajuste selon la forme de ta carte
        children: patterns
            .map(
              (pattern) =>
                  PatternTile(pattern: pattern, openPatternForm: openPatternForm),
            )
            .toList(),
      );
    }
  }
}
