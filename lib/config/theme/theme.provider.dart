import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'color.module.dart';

/// Toggle the Theme mode
/// set -> ref.read(themeMode.notifier).state = ThemeMode.light;
/// get -> final mode = ref.watch(themeMode);
final themeMode = StateProvider<ThemeMode>((ref) => ThemeMode.light);

final lightThemeData = ThemeData(
  // This is the theme of your application.
  //
  // TRY THIS: Try running your application with "flutter run". You'll see
  // the application has a blue toolbar. Then, without quitting the app,
  // try changing the seedColor in the colorScheme below to Colors.green
  // and then invoke "hot reload" (save your changes or press the "hot
  // reload" button in a Flutter-supported IDE, or press "r" if you used
  // the command line to start the app).
  //
  // Notice that the counter didn't reset back to zero; the application
  // state is not lost during the reload. To reset the state, use hot
  // restart instead.
  //
  // This works for code too, not just values: Most code changes can be
  // tested with just a hot reload.
  colorScheme: ColorScheme.fromSeed(seedColor: ThemeColor.primary),
  appBarTheme: const AppBarTheme(
    color: ThemeColor.primary,
    elevation: 0,
    centerTitle: true,
  ),
  useMaterial3: true,
  brightness: Brightness.light,
  // scaffoldBackgroundColor: Colors.white,
);

final darkThemeData = ThemeData(brightness: Brightness.dark);

final colorScheme = ColorScheme.fromSeed(seedColor: ThemeColor.primary);

// const colorScheme = ColorScheme(
//   brightness: Brightness.light,
//   primary: ThemeColor.primary,
//   onPrimary: ThemeColor.onPrimary,
//   secondary: ThemeColor.secondary,
//   onSecondary: ThemeColor.onSecondary,
//   error: ThemeColor.error,
//   onError: ThemeColor.onError,
//   background: ThemeColor.background,
//   onBackground: ThemeColor.onBackground,
//   surface: ThemeColor.surface,
//   onSurface: ThemeColor.onSurface,
// );

    // Color? primaryContainer,
    // Color? onPrimaryContainer,
    // Color? secondaryContainer,
    // Color? onSecondaryContainer,
    // Color? tertiary,
    // Color? onTertiary,
    // Color? tertiaryContainer,
    // Color? onTertiaryContainer,
    // Color? errorContainer,
    // Color? onErrorContainer,
    // Color? surfaceVariant,
    // Color? onSurfaceVariant,
    // Color? outline,
    // Color? outlineVariant,
    // Color? shadow,
    // Color? scrim,
    // Color? inverseSurface,
    // Color? onInverseSurface,
    // Color? inversePrimary,
    // Color? surfaceTint,