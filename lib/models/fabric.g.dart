// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fabric.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FabricAdapter extends TypeAdapter<Fabric> {
  @override
  final int typeId = 1;

  @override
  Fabric read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fabric(
      id: fields[0] as String?,
      name: fields[1] as String,
      description: fields[2] as String?,
      type: fields[3] as FabricType?,
      brand: fields[4] as Brand?,
      weave: fields[5] as String?,
      materials: (fields[6] as List?)?.cast<MaterialModel>(),
      seasons: (fields[7] as List?)?.cast<Season>(),
      quantity: fields[8] as double?,
      colours: (fields[9] as List?)?.cast<Colour>(),
      width: fields[10] as int?,
      extensiveness: fields[11] as double?,
      price: fields[12] as double?,
      images: (fields[13] as List?)?.cast<String>(),
      link: fields[14] as String?,
      notes: fields[15] as String?,
      isFavorite: fields[16] as bool,
      userId: fields[17] as String?,
      isSynced: fields[18] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Fabric obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.brand)
      ..writeByte(5)
      ..write(obj.weave)
      ..writeByte(6)
      ..write(obj.materials)
      ..writeByte(7)
      ..write(obj.seasons)
      ..writeByte(8)
      ..write(obj.quantity)
      ..writeByte(9)
      ..write(obj.colours)
      ..writeByte(10)
      ..write(obj.width)
      ..writeByte(11)
      ..write(obj.extensiveness)
      ..writeByte(12)
      ..write(obj.price)
      ..writeByte(13)
      ..write(obj.images)
      ..writeByte(14)
      ..write(obj.link)
      ..writeByte(15)
      ..write(obj.notes)
      ..writeByte(16)
      ..write(obj.isFavorite)
      ..writeByte(17)
      ..write(obj.userId)
      ..writeByte(18)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FabricAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
