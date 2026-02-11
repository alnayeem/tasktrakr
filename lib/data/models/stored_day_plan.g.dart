// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_day_plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoredDayPlanAdapter extends TypeAdapter<StoredDayPlan> {
  @override
  final int typeId = 1;

  @override
  StoredDayPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoredDayPlan(
      id: fields[0] as String,
      goalId: fields[1] as String,
      day: fields[2] as int,
      date: fields[3] as String,
      task: fields[4] as String?,
      taskShort: fields[5] as String?,
      estimatedMinutes: fields[6] as int?,
      notes: fields[7] as String?,
      intensity: fields[8] as String?,
      ramadanPhase: fields[9] as String?,
      isLaylaulQadrNight: fields[10] as bool,
      status: fields[11] as String,
      minutesCompleted: fields[12] as int,
      startedAt: fields[13] as String?,
      completedAt: fields[14] as String?,
      userNotes: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoredDayPlan obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.goalId)
      ..writeByte(2)
      ..write(obj.day)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.task)
      ..writeByte(5)
      ..write(obj.taskShort)
      ..writeByte(6)
      ..write(obj.estimatedMinutes)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.intensity)
      ..writeByte(9)
      ..write(obj.ramadanPhase)
      ..writeByte(10)
      ..write(obj.isLaylaulQadrNight)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.minutesCompleted)
      ..writeByte(13)
      ..write(obj.startedAt)
      ..writeByte(14)
      ..write(obj.completedAt)
      ..writeByte(15)
      ..write(obj.userNotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoredDayPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
