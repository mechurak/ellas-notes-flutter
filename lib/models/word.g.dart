// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 3;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      sheetId: fields[0] as String,
      chapterNameForId: fields[1] as String,
      order: fields[2] as int,
      quizType: fields[3] as int,
      text: fields[4] as String,
      hint: fields[5] as String?,
      note: fields[6] as String?,
      memo: fields[7] as String?,
      link: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.sheetId)
      ..writeByte(1)
      ..write(obj.chapterNameForId)
      ..writeByte(2)
      ..write(obj.order)
      ..writeByte(3)
      ..write(obj.quizType)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.hint)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.memo)
      ..writeByte(8)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
