import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/core/id/injection.dart';
import 'package:meer_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:meer_flutter/presentation/auth/login/screen/login_screen.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/bloc/verify_otp_bloc.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/screen/verify_otp_screen.dart';
import 'package:meer_flutter/presentation/home/screen/home_screen.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String? finalRouteName = settings.name;

    // تطبيق منطق الـ Middleware عند الدخول للتطبيق

    if (finalRouteName == AppRoute.loginScreen && client.auth.isAuthenticated) {
      finalRouteName = AppRoute.homeScreen;
    } else if (finalRouteName == AppRoute.homeScreen &&
        !client.auth.isAuthenticated) {
      finalRouteName = AppRoute.loginScreen;
    }

    switch (finalRouteName) {
      case AppRoute.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<LoginBloc>(),
            child: const LoginScreen(),
          ),
        );
      case AppRoute.verifyOtpScreen:
        final phone = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<VerifyOtpBloc>(),
            child: VerifyOtpScreen(
              phone: phone,
            ),
          ),
        );
      case AppRoute.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      default:
        return null;
    }
  }
}
