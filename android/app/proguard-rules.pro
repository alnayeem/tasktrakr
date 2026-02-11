# Flutter-specific ProGuard rules

# Keep Flutter classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Hive classes
-keep class ** extends com.google.gson.TypeAdapter { *; }
-keep class ** extends com.google.gson.TypeAdapterFactory { *; }
-keep class ** extends com.google.gson.JsonSerializer { *; }
-keep class ** extends com.google.gson.JsonDeserializer { *; }

# Keep notification classes
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Keep Kotlin serialization
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.AnnotationsKt

# Keep R8 from stripping interface information
-keepattributes Signature

# For debugging (remove in production if needed)
-keepattributes SourceFile,LineNumberTable

# Play Core library - ignore missing classes (not using deferred components)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**
