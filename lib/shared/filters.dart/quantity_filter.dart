import 'package:flutter/material.dart';

class QuantityFilter extends StatelessWidget {
  final double mininumQuantity;
  final ValueChanged<double> onChanged;

  const QuantityFilter({
    super.key,
    required this.mininumQuantity,
    required this.onChanged,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Longueur minimale : ${mininumQuantity.toStringAsFixed(2)} m'),
        Slider(
          value: mininumQuantity,
          min: 0.0,
          max: 10.0,
          divisions: 100,
          label: '${mininumQuantity.toStringAsFixed(2)} m',
          onChanged: onChanged,
        ),
      ],
    );
  }


}
