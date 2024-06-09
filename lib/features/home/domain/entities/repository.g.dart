// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepositoryAdapter extends TypeAdapter<Repository> {
  @override
  final int typeId = 0;

  @override
  Repository read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Repository(
      name: fields[0] as String,
      description: fields[1] as String,
      owner: fields[2] as String,
      isFork: fields[3] as bool,
      repoUrl: fields[4] as String,
      ownerUrl: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Repository obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.owner)
      ..writeByte(3)
      ..write(obj.isFork)
      ..writeByte(4)
      ..write(obj.repoUrl)
      ..writeByte(5)
      ..write(obj.ownerUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepositoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
