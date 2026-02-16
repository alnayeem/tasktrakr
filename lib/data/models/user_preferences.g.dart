// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPreferencesAdapter extends TypeAdapter<UserPreferences> {
  @override
  final int typeId = 2;

  @override
  UserPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPreferences(
      language: fields[0] as String,
      notificationsEnabled: fields[1] as bool,
      reminderTime: fields[2] as String?,
      theme: fields[3] as String,
      hapticsEnabled: fields[4] as bool,
      soundEnabled: fields[5] as bool,
      onboardingCompleted: fields[6] as bool,
      userId: fields[7] as String?,
      hasSeenAuthPrompt: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferences obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.language)
      ..writeByte(1)
      ..write(obj.notificationsEnabled)
      ..writeByte(2)
      ..write(obj.reminderTime)
      ..writeByte(3)
      ..write(obj.theme)
      ..writeByte(4)
      ..write(obj.hapticsEnabled)
      ..writeByte(5)
      ..write(obj.soundEnabled)
      ..writeByte(6)
      ..write(obj.onboardingCompleted)
      ..writeByte(7)
      ..write(obj.userId)
      ..writeByte(8)
      ..write(obj.hasSeenAuthPrompt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
