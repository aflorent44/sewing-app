import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/project.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final void Function(Project project) openForm;
  final String? imageUrl = 'assets/images/sheet.png';
  final String? imagePlaceholderUrl = 'assets/images/general-img-square.png';

  const ProjectTile({super.key, required this.project, required this.openForm});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openForm(project),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/sheet.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 36.0,
                left: 16.0,
                right: 16.0,
                bottom: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          project.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.black87),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
