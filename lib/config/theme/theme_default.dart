import 'color/banana_color.dart';
import 'theme.dart';
import 'theme.enum.dart';

class DefaultTheme extends ITheme {
  DefaultTheme()
      : super(
          color: BananaColor(),
          fontFamily: ThemeFontFamily.Roboto,
          buttonBorderRadius: 3,
        );
}
