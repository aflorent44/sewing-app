import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/inspiration.dart';

class InspirationTile extends StatelessWidget {
  final Inspiration inspiration;
  final void Function(Inspiration inspiration) openForm;
  final String? imageUrl = 'assets/images/sheet.png';
  final String? imagePlaceholderUrl = 'assets/images/general-img-square.png';

  const InspirationTile({
    super.key,
    required this.inspiration,
    required this.openForm,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openForm(inspiration),
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
                          inspiration.name,
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
