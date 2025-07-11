// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colour.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColourAdapter extends TypeAdapter<Colour> {
  @override
  final int typeId = 3;

  @override
  Colour read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Colour.black;
      case 1:
        return Colour.blue;
      case 2:
        return Colour.brown;
      case 3:
        return Colour.gray;
      case 4:
        return Colour.green;
      case 5:
        return Colour.orange;
      case 6:
        return Colour.pink;
      case 7:
        return Colour.purple;
      case 8:
        return Colour.red;
      case 9:
        return Colour.white;
      case 10:
        return Colour.yellow;
      case 11:
        return Colour.beige;
      default:
        return Colour.black;
    }
  }

  @override
  void write(BinaryWriter writer, Colour obj) {
    switch (obj) {
      case Colour.black:
        writer.writeByte(0);
        break;
      case Colour.blue:
        writer.writeByte(1);
        break;
      case Colour.brown:
        writer.writeByte(2);
        break;
      case Colour.gray:
        writer.writeByte(3);
        break;
      case Colour.green:
        writer.writeByte(4);
        break;
      case Colour.orange:
        writer.writeByte(5);
        break;
      case Colour.pink:
        writer.writeByte(6);
        break;
      case Colour.purple:
        writer.writeByte(7);
        break;
      case Colour.red:
        writer.writeByte(8);
        break;
      case Colour.white:
        writer.writeByte(9);
        break;
      case Colour.yellow:
        writer.writeByte(10);
        break;
      case Colour.beige:
        writer.writeByte(11);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColourAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
