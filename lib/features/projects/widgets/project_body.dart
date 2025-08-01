import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/projects/widgets/project_tile.dart';
import 'package:mon_app_couture/models/project.dart';

class ProjectsBody extends StatelessWidget {
  final List<Project> projects;
  final bool isLoading;
  final bool hasError;
  final void Function(Project?) openForm;

  const ProjectsBody({
    super.key,
    required this.projects,
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
    } else if (projects.isEmpty) {
      return Center(child: Text('Aucun projet à afficher.'));
    } else {
      return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        padding: const EdgeInsets.all(2),
        childAspectRatio: 1 / 1.2, // 👉 Ajuste selon la forme de ta carte
        children: projects
            .map((element) => ProjectTile(project: element, openForm: openForm))
            .toList(),
      );
    }
  }
}
