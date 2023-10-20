import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/service/localization/localization.dart';
import 'core/service/monitoring/navigation_observer.module.dart';

import 'config/constant/nav.constant.dart';
import 'config/theme/theme.provider.dart';
import 'core/service/navigation.service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      darkTheme: darkThemeData,
      navigatorKey: NavigationService.navigationKey,
      initialRoute: ConstantNav.landingRoute,
      onGenerateRoute: ConstantNav.generateRoute,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [NavigationObserver()],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Localization.supportedLocales,
    );
  }
}
