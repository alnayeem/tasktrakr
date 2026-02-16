// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoredGoalAdapter extends TypeAdapter<StoredGoal> {
  @override
  final int typeId = 0;

  @override
  StoredGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoredGoal(
      id: fields[0] as String,
      title: fields[1] as String,
      titleShort: fields[2] as String,
      category: fields[3] as String,
      icon: fields[4] as String,
      description: fields[5] as String,
      language: fields[6] as String,
      durationDays: fields[7] as int,
      startDate: fields[8] as String,
      endDate: fields[9] as String,
      difficulty: fields[10] as String,
      specialMode: fields[11] as String?,
      tasksCompleted: fields[12] as int,
      tasksTotal: fields[13] as int,
      currentStreak: fields[14] as int,
      bestStreak: fields[15] as int,
      createdAt: fields[16] as String,
      updatedAt: fields[17] as String,
      userId: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoredGoal obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.titleShort)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.icon)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.durationDays)
      ..writeByte(8)
      ..write(obj.startDate)
      ..writeByte(9)
      ..write(obj.endDate)
      ..writeByte(10)
      ..write(obj.difficulty)
      ..writeByte(11)
      ..write(obj.specialMode)
      ..writeByte(12)
      ..write(obj.tasksCompleted)
      ..writeByte(13)
      ..write(obj.tasksTotal)
      ..writeByte(14)
      ..write(obj.currentStreak)
      ..writeByte(15)
      ..write(obj.bestStreak)
      ..writeByte(16)
      ..write(obj.createdAt)
      ..writeByte(17)
      ..write(obj.updatedAt)
      ..writeByte(18)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoredGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
