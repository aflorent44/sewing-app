// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeasonAdapter extends TypeAdapter<Season> {
  @override
  final int typeId = 2;

  @override
  Season read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Season.spring;
      case 1:
        return Season.summer;
      case 2:
        return Season.autumn;
      case 3:
        return Season.winter;
      default:
        return Season.spring;
    }
  }

  @override
  void write(BinaryWriter writer, Season obj) {
    switch (obj) {
      case Season.spring:
        writer.writeByte(0);
        break;
      case Season.summer:
        writer.writeByte(1);
        break;
      case Season.autumn:
        writer.writeByte(2);
        break;
      case Season.winter:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeasonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
