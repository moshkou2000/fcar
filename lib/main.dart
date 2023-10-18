import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/constant/nav.constant.dart';
import 'core/service/navigation.service.dart';
import 'feature/landing/landing.view.dart';
import 'package:flutter/material.dart';

import 'shared/domain/provider/localization/localization.service.dart';

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
      theme: ThemeData(
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
          elevation: 0,
          centerTitle: true,
        ),
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const LandingView(),
      navigatorKey: NavigationService.navigationKey,
      initialRoute: ConstantNav.homeRoute,
      onGenerateRoute: ConstantNav.generateRoute,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      navigatorObservers: const [
        // TODO: after setup the analytics
        // AnalyticsProvider.analytics.observer,
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: localizationService.supportedLocales(),
    );
  }
}
