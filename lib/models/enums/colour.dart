import 'package:hive/hive.dart';

part 'colour.g.dart';

@HiveType(typeId: 3)
enum Colour {
  @HiveField(0)
  black,
  @HiveField(1)
  blue,
  @HiveField(2)
  brown,
  @HiveField(3)
  gray,
  @HiveField(4)
  green,
  @HiveField(5)
  orange,
  @HiveField(6)
  pink,
  @HiveField(7)
  purple,
  @HiveField(8)
  red,
  @HiveField(9)
  white,
  @HiveField(10)
  yellow,
  @HiveField(11)
  beige;

  static Colour fromJson(String name) {
    return Colour.values.firstWhere((e) => e.name == name);
  }

  String toJson() => name;
}

extension ColourExtension on Colour {
  String get label {
    switch (this) {
      case Colour.black:
        return '⚫️';
      case Colour.blue:
        //emoji bleu
        return '🔵';
      case Colour.brown:
        //emoji marron
        return '🟤';
      case Colour.gray:
        //emoji d'immeuble gris
        return '🏢';
      case Colour.green:
        //emoji vert
        return '🟢';
      case Colour.orange:
        //emoji orange
        return '🟠';
      case Colour.pink:
        //emoji de coeur rose clair
        return '🩷';
      case Colour.purple:
        //emoji violet
        return '🟣';
      case Colour.red:
        //emoji rouge
        return '🔴';
      case Colour.white:
        //emoji blanc
        return '⚪️';
      case Colour.yellow:
        //emoji jaune
        return '🟡';
      case Colour.beige:
        //emoji tête d'humain beige
        return '🧑🏻';
    }
  }
}
