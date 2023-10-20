/// Reference to the given color dataset
/// export only one
// export 'banana_color.dart';
// export 'persian_color.dart';
export 'color/korra_color.dart';


/// each [*_color.dart] must implement the [ThemeColor]
/// duplicate the code and set the value.
///
/// @immutable
/// final class ThemeColor {
///   static const primary = Color(...);
///   static const onPrimary = Color(...);
///   static const primaryContainer = Color(...);
///   static const onPrimaryContainer = Color(...);
///   static const secondary = Color(...);
///   static const onSecondary = Color(...);
///   static const secondaryContainer = Color(...);
///   static const onSecondaryContainer = Color(...);
///   static const tertiary = Color(...);
///   static const onTertiary = Color(...);
///   static const tertiaryContainer = Color(...);
///   static const onTertiaryContainer = Color(...);
///   static const error = Color(...);
///   static const errorContainer = Color(...);
///   static const surface = Color(...);
///   static const surfaceVariant = Color(...);
///   static const inverseSurface = Color(...);
///   static const inversePrimary = Color(...);
///   static const outline = Color(...);
///   static const background = Color(...);
///   static const shadow = Color(...);
///   static const overlay = Color(...);
/// }