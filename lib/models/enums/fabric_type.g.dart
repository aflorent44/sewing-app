// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fabric_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FabricTypeAdapter extends TypeAdapter<FabricType> {
  @override
  final int typeId = 4;

  @override
  FabricType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FabricType.woven;
      case 1:
        return FabricType.knitted;
      case 2:
        return FabricType.nonWoven;
      default:
        return FabricType.woven;
    }
  }

  @override
  void write(BinaryWriter writer, FabricType obj) {
    switch (obj) {
      case FabricType.woven:
        writer.writeByte(0);
        break;
      case FabricType.knitted:
        writer.writeByte(1);
        break;
      case FabricType.nonWoven:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FabricTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
