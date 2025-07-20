import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/fabric.dart';

class FabricTile extends StatelessWidget {
  final Fabric fabric;
  final void Function(Fabric fabric) openFabricForm;
  final String? imageUrl = 'assets/images/sheet.png';
  final String? imagePlaceholderUrl = 'assets/images/general-img-square.png';

  const FabricTile({
    super.key,
    required this.fabric,
    required this.openFabricForm,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openFabricForm(fabric),
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
                          fabric.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.black87),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      if (fabric.isFavorite)
                        const Icon(Icons.favorite, color: Colors.red, size: 18),
                    ],
                  ),
                  if (fabric.brand != null && fabric.brand != "")
                    Text(
                      fabric.brand!,
                      style: TextStyle(color: Colors.black45),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  if (fabric.brand == null || fabric.brand == "")
                    const Text("--", style: TextStyle(color: Colors.black45)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: fabric.materials!
                          .map(
                            (material) => Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Chip(
                                label: Text(
                                  material.name,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary,
                                  ),
                                ),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelPadding: const EdgeInsets.all(0),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  if (fabric.materials == null || fabric.materials!.isEmpty)
                    const Text("--", style: TextStyle(color: Colors.black45)),
                  const SizedBox(height: 4),
                  if (fabric.quantity != null)
                    Text(
                      '${fabric.quantity!.toStringAsFixed(1)} m',
                      style: TextStyle(color: Colors.black45),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: _image(imagePlaceholderUrl!),
                  ),

                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (fabric.colours != null && fabric.colours!.isNotEmpty)
                        Row(
                          children: fabric.colours!
                              .take(4)
                              .map(
                                (c) => Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: colorCircle(c, 14),
                                ),
                              )
                              .toList(),
                        ),
                      if (fabric.seasons != null && fabric.seasons!.isNotEmpty)
                        Expanded(
                          child: Text(
                            fabric.seasons!.map((s) => s.emoji).join(' '),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
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

  Widget _image(String imageUrl) {
    return Image.asset(imageUrl, width: 40, height: 40, fit: BoxFit.contain);
  }
}
