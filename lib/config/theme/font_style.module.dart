/// Reference to the given font dataset
/// export only one
export 'font/roboto_style.dart';

/// each [*_style.dart] must implement the [ThemeFont]
/// duplicate the code and set the value.
///
/// @immutable
/// final class ThemeFont {
///   static const fontFamily = 'give the fontfamily here';
///   static const textStyle = TextStyle(fontFamily: fontFamily);
///   static final titleStyle = textStyle
///     ..copyWith(fontSize: ..., fontWeight: FontWeight...);
///   static final subtitleStyle = textStyle
///     ..copyWith(fontSize: ..., fontWeight: FontWeight...);
///   static final buttonTextStyle = textStyle
///     ..copyWith(fontSize: ..., fontWeight: FontWeight...);
/// }