// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataModelAdapter extends TypeAdapter<UserDataModel> {
  @override
  final int typeId = 0;

  @override
  UserDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataModel()
      ..userDataUsername = fields[0] as String?
      ..userDataEmail = fields[1] as String?
      ..userDataExperienceLevel = fields[2] as String?
      ..languages = (fields[3] as List).cast<String>()
      ..userDataExperienceTime = fields[4] as String?
      ..userDataSallary = fields[5] as double?;
  }

  @override
  void write(BinaryWriter writer, UserDataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userDataUsername)
      ..writeByte(1)
      ..write(obj.userDataEmail)
      ..writeByte(2)
      ..write(obj.userDataExperienceLevel)
      ..writeByte(3)
      ..write(obj.languages)
      ..writeByte(4)
      ..write(obj.userDataExperienceTime)
      ..writeByte(5)
      ..write(obj.userDataSallary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
