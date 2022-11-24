// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateQrAdapter extends TypeAdapter<CreateQr> {
  @override
  final int typeId = 1;

  @override
  CreateQr read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateQr(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreateQr obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.qrCodeValue)
      ..writeByte(1)
      ..write(obj.formate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateQrAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
