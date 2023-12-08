import 'package:fcar_lib/core/service/localization/localization.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:fcar_lib/core/service/monitoring/navigation_observer/sentry_navigator_observer.dart';

import 'config/theme/theme.provider.dart';
import 'core/service/navigation/navigation_route.dart';

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
      navigatorKey: Navigation.navigationKey,
      initialRoute: NavigationRoute.splashscreenRoute,
      onGenerateRoute: NavigationRoute.generateRoute,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [SentryNavigatorObservers()],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LocalizationProvider.supportedLocales,
    );
  }
}
