// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 1;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      subjectId: fields[0] as int,
      title: fields[1] as String,
      sheetId: fields[2] as String,
      lastUpdate: fields[3] as DateTime,
      description: fields[4] as String,
      link: fields[5] as String,
      imageUrl: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.subjectId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.sheetId)
      ..writeByte(3)
      ..write(obj.lastUpdate)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.link)
      ..writeByte(6)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
