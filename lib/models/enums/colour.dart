import 'package:flutter/material.dart';

enum Colour {
  red,
  orange,
  yellow,
  green,
  blue,
  purple,
  pink,
  brown,
  beige,
  white,
  gray,
  black;

  static Colour fromJson(String name) {
    return Colour.values.firstWhere((e) => e.name == name);
  }

  String toJson() => name;
}

Color mapColourToColor(Colour colour) {
  switch (colour) {
    case Colour.red:
      return Colors.red;
    case Colour.orange:
      return Colors.orange;
    case Colour.yellow:
      return Colors.yellow;
    case Colour.green:
      return Colors.green;
    case Colour.blue:
      return Colors.blue;
    case Colour.purple:
      return Colors.purple;
    case Colour.pink:
      return Colors.pink;
    case Colour.brown:
      return Colors.brown;
    case Colour.beige:
      return Color.fromARGB(255, 228, 180, 162);
    case Colour.white:
      return Colors.white;
    case Colour.gray:
      return Colors.grey;
    case Colour.black:
      return Colors.black;
    }
}

Widget colorCircle(Colour colour, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: mapColourToColor(colour),
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade300),
    ),
  );
}
