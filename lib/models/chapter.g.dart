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
      subjectKey: fields[0] as int,
      nameForKey: fields[1] as String,
      title: fields[2] as String,
      category: fields[3] as String?,
      remoteUrl: fields[4] as String?,
      localUrl: fields[5] as String?,
      link1: fields[6] as String?,
      link2: fields[7] as String?,
      lastStudyDate: fields[8] as DateTime,
      studyPoint: fields[9] as int,
      quizCount: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Chapter obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.subjectKey)
      ..writeByte(1)
      ..write(obj.nameForKey)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.remoteUrl)
      ..writeByte(5)
      ..write(obj.localUrl)
      ..writeByte(6)
      ..write(obj.link1)
      ..writeByte(7)
      ..write(obj.link2)
      ..writeByte(8)
      ..write(obj.lastStudyDate)
      ..writeByte(9)
      ..write(obj.studyPoint)
      ..writeByte(10)
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
