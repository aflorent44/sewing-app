import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/pattern_model.dart';

class PatternTile extends StatelessWidget {
  final PatternModel pattern;
  final void Function(PatternModel pattern) openPatternForm;
  final String? imageUrl = 'assets/images/sheet.png';
  final String? imagePlaceholderUrl = 'assets/images/general-img-square.png';

  const PatternTile({
    super.key,
    required this.pattern,
    required this.openPatternForm,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openPatternForm(pattern),
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
                          pattern.name,
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
