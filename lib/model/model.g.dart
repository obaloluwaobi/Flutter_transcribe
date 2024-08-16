// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranscribeModelAdapter extends TypeAdapter<TranscribeModel> {
  @override
  final int typeId = 1;

  @override
  TranscribeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranscribeModel(
      words: fields[0] as String,
      translate: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TranscribeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.words)
      ..writeByte(1)
      ..write(obj.translate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranscribeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
