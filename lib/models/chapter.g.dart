// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterAdapter extends TypeAdapter<Chapter> {
  @override
  final int typeId = 2;

  @override
  Chapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chapter(
      key: fields[0] as int,
      subjectKey: fields[1] as int,
      nameForId: fields[2] as String,
      title: fields[3] as String,
      category: fields[4] as String?,
      remoteUrl: fields[5] as String?,
      localUrl: fields[6] as String?,
      link1: fields[7] as String?,
      link2: fields[8] as String?,
      lastStudyDate: fields[9] as DateTime,
      studyPoint: fields[10] as int,
      quizCount: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Chapter obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.subjectKey)
      ..writeByte(2)
      ..write(obj.nameForId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.remoteUrl)
      ..writeByte(6)
      ..write(obj.localUrl)
      ..writeByte(7)
      ..write(obj.link1)
      ..writeByte(8)
      ..write(obj.link2)
      ..writeByte(9)
      ..write(obj.lastStudyDate)
      ..writeByte(10)
      ..write(obj.studyPoint)
      ..writeByte(11)
      ..write(obj.quizCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
