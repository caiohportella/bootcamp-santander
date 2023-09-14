// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonModelAdapter extends TypeAdapter<PersonModel> {
  @override
  final int typeId = 1;

  @override
  PersonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonModel()
      ..personID = fields[0] as int
      ..personName = fields[1] as String
      ..personWeight = fields[2] as double
      ..personHeight = fields[3] as double
      ..personBMI = fields[4] as double
      ..personHasGoodBMI = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, PersonModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.personID)
      ..writeByte(1)
      ..write(obj.personName)
      ..writeByte(2)
      ..write(obj.personWeight)
      ..writeByte(3)
      ..write(obj.personHeight)
      ..writeByte(4)
      ..write(obj.personBMI)
      ..writeByte(5)
      ..write(obj.personHasGoodBMI);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
