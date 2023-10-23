import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/service/localization/localization.dart';
import 'core/service/monitoring/navigation_observer.module.dart';

import 'config/constant/nav.constant.dart';
import 'config/theme/theme.provider.dart';
import 'core/service/navigation.service.dart';
import 'package:flutter/material.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeMode);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: mode,
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
