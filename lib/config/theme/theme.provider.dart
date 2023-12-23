import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_color.dart';
import 'theme_font.dart';

/// Example Usage
/// Text('Hello, Flutter!',
///   style: Theme.of(context).textTheme.headlineMedium);
///

/// Toggle the Theme mode
/// set -> ref.read(themeMode.notifier).state = ThemeMode.light;
/// get -> final mode = ref.watch(themeMode);
final themeMode = StateProvider<ThemeMode>((ref) => ThemeMode.light);

ThemeData get darkThemeData => ThemeData(brightness: Brightness.dark);
ThemeData get lightThemeData => ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ThemeColor.navigationBarColor,
        foregroundColor: Colors.white,
      ),
      snackBarTheme: const SnackBarThemeData(
        actionTextColor: Colors.white,
        backgroundColor: ThemeColor.surface,
        contentTextStyle: TextStyle(color: Colors.white),
        closeIconColor: Colors.white,
        insetPadding: EdgeInsets.all(8.0),
        elevation: 2.0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.shifting,
        elevation: 0.0,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
        shape: CircularNotchedRectangle(),
      ),
      textTheme: TextTheme(
        displayLarge: ThemeFont.displayLarge,
        displayMedium: ThemeFont.displayMedium,
        displaySmall: ThemeFont.displaySmall,

        headlineLarge: ThemeFont.headingLarge,
        headlineMedium: ThemeFont.headingMedium,
        headlineSmall: ThemeFont.headingSmall,

        // titleLarge: ThemeFont.tit,
        // titleMedium: ThemeFont.headingLarge,
        // titleSmall: ThemeFont.headingLarge,

        // bodyLarge: ThemeFont.headingLarge,
        // bodyMedium: ThemeFont.headingLarge,
        // bodySmall: ThemeFont.headingLarge,

        // labelLarge: ThemeFont.label,
        // labelMedium: ThemeFont.headingLarge,
        // labelSmall: ThemeFont.lab,
      ),
    );

ColorScheme get colorScheme => const ColorScheme(
      brightness: Brightness.light,
      primary: ThemeColor.primary,
      onPrimary: ThemeColor.onPrimary,
      secondary: ThemeColor.secondary,
      onSecondary: ThemeColor.onSecondary,
      error: ThemeColor.error,
      onError: ThemeColor.onError,
      background: ThemeColor.background,
      onBackground: ThemeColor.onBackground,
      surface: ThemeColor.surface,
      onSurface: ThemeColor.onSurface,
      // optional
      // primaryContainer: ThemeColor.primaryContainer,
      // onPrimaryContainer: ThemeColor.onPrimaryContainer,
      // secondaryContainer: ThemeColor.secondaryContainer,
      // onSecondaryContainer: ThemeColor.onSecondaryContainer,
      // tertiary: ThemeColor.tertiary,
      // onTertiary: ThemeColor.onTertiary,
      // tertiaryContainer: ThemeColor.tertiaryContainer,
      // onTertiaryContainer: ThemeColor.onTertiaryContainer,
      // errorContainer: ThemeColor.errorContainer,
      // onErrorContainer: ThemeColor.onErrorContainer,
      // surfaceVariant: ThemeColor.surfaceVariant,
      // onSurfaceVariant: ThemeColor.onSurfaceVariant,
      // outline: ThemeColor.outline,
      // outlineVariant: ThemeColor.outlineVariant,
      // shadow: ThemeColor.shadow,
      // scrim: ThemeColor.scrim,
      // inverseSurface: ThemeColor.inverseSurface,
      // onInverseSurface: ThemeColor.onInverseSurface,
      // inversePrimary: ThemeColor.inversePrimary,
      // surfaceTint: ThemeColor.surfaceTint,
    );

/// Manage the System Overlay visibility and style,
/// anywhere in the code.
///
/// It's bette to use [PostFrameCallback],
/// If you are seting the System Overlay in the widget
/// Example: call in the [initState] of [LandingView]
/// WidgetsBinding.instance.addPostFrameCallback((_) {
///   hideOverlays();
///   themeSetSystemUIOverlayStyle();});
///

/// System Overlay style
void themeSetSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ThemeColor.statusBarColor,
    systemNavigationBarColor: ThemeColor.navigationBarColor,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

/// System Overlay style
void themeInitSystemUIOverlayStyle({Color? navigationBarColor}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor:
        navigationBarColor ?? Colors.black.withOpacity(0.01),
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
}

/// System Overlay visibility [hide]
/// both StatusBar & NavigationBar
///
/// Games are usually run on fullscreen mode.
///
/// Android project
/// Notch Area might be blank when StatusBar is disabled.
/// To remove the blank area, add the following attribute in the resources style,
/// that can be found at android/app/src/main/res/values/styles.
/// <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>
void hideOverlays() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [
    SystemUiOverlay.bottom,
    SystemUiOverlay.top,
  ]);
}

/// System Overlay visibility [show]
/// both StatusBar & NavigationBar
void showOverlays() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [
    SystemUiOverlay.bottom,
    SystemUiOverlay.top,
  ]);
}
