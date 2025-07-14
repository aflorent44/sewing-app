import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/fabric.dart';

class FabricTile extends StatelessWidget {
  final Fabric fabric;
  final void Function(Fabric fabric) openFabricForm;

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
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fabric.name, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 2),
              if (fabric.quantity != null)
                Text('${fabric.quantity!.toStringAsFixed(1)} m'),
              if (fabric.materials != null && fabric.materials!.isNotEmpty)
                Text(fabric.materials!.map((m) => m.name).join(', ')),
                            
              Row(
                children: [
                  if (fabric.colours != null && fabric.colours!.isNotEmpty)
                    Wrap(
                      spacing: 4,
                      children: fabric.colours!
                          .map((c) => _colorCircle(c))
                          .toList(),
                    ),
                  if (fabric.seasons != null && fabric.seasons!.isNotEmpty)
                    Text(fabric.seasons!.map((s) => s.label).join(', ')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _colorCircle(Colour colour) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: mapColourToColor(colour),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
    );
  }
}
