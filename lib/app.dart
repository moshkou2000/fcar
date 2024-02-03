import 'package:fcar_lib/core/service/localization/localization.provider.dart';
import 'package:fcar_lib/core/service/monitoring/navigation_observer/sentry_navigator_observer.dart';
import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.provider.dart';
import 'config/theme/theme.provider.dart';
import 'core/service/navigation/navigation_route.dart';

class App extends ConsumerWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(appProvider);

    logger.info(result.value);

    if (result.isLoading) {
      return const SizedBox();
    } else if (result.hasError) {
      return const Text('Oopsy!');
    }

    return const _App();
  }
}

class _App extends ConsumerWidget {
  const _App();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final initialRoute = ref.watch(navigationProvider);

    logger.info(mode);
    logger.info(initialRoute);

    return MaterialApp(
      title: AppProvider.name,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: mode,
      navigatorKey: Navigation.navigationKey,
      initialRoute: initialRoute,
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
