import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/app_router.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/core/id/injection.dart';
import 'package:meer_flutter/core/routes/app_route_observer.dart';
import 'package:meer_flutter/core/services/app_service.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:meer_flutter/presentation/search/bloc/search_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meer_flutter/core/storage/hive/hive_service.dart';

import 'client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialService();
  await HiveService().init();
  await initializeClient();
  await initGetIt();

  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) =>
        //       LocalizationBloc()
        //         ..add(LocalizationEvent.loadSavedLocalization()),
        // ),
        BlocProvider(
          create: (_) => sl<CartBloc>(),
        ),
        BlocProvider(create: (context) => sl<SearchBloc>()),
        BlocProvider(
          create: (_) => sl<FavoritesBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

ThemeData _buildTheme(Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF286B55),
    brightness: brightness,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,

    // خلفية التطبيق
    scaffoldBackgroundColor: brightness == Brightness.light
        ? const Color(0xFFF7F9F6)
        : colorScheme.surface,

    // الشريط العلوي
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(
        color: colorScheme.onPrimary,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مِيْر',

      // اللغة الافتراضية
      locale: const Locale('ar'),

      // اللغات المدعومة
      supportedLocales: const [
        Locale('ar'),
        // Locale('en'), // أضفها إذا أردت دعم الإنجليزية مستقبلاً
      ],

      // دعم الترجمة في Flutter
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,

      navigatorObservers: [AppRouteObserver()],
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoute.loginScreen,
    );
  }
}
