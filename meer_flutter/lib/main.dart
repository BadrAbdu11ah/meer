import 'package:flutter/material.dart';
import 'package:meer_flutter/app_router.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/core/id/injection.dart';
import 'package:meer_flutter/core/routes/app_route_observer.dart';
import 'package:meer_flutter/core/services/app_service.dart';

import 'client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialService();
  await initializeClient();
  await initGetIt();

  runApp(const MyApp());
}

/// Builds a theme for the given [brightness].
ThemeData _buildTheme(Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: brightness,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meer App',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      navigatorObservers: [AppRouteObserver()],
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoute.loginScreen,
    );
  }
}
