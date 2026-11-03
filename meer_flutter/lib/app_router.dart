import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/core/id/injection.dart';
import 'package:meer_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:meer_flutter/presentation/auth/login/screen/login_screen.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/bloc/verify_otp_bloc.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/screen/verify_otp_screen.dart';
import 'package:meer_flutter/presentation/cart/screen/cart_screen.dart';
import 'package:meer_flutter/presentation/checkout/bloc/checkout_bloc.dart';
import 'package:meer_flutter/presentation/checkout/screen/checkout_screen.dart';
import 'package:meer_flutter/presentation/main/bloc/main_bloc.dart';
import 'package:meer_flutter/presentation/main/screen/main_screen.dart';
import 'package:meer_flutter/presentation/product_details/screen/product_details_screen.dart';
import 'package:meer_flutter/presentation/product_form/bloc/product_form_bloc.dart';
import 'package:meer_flutter/presentation/product_form/screen/product_form_screen.dart';
import 'package:meer_flutter/presentation/seller_details/bloc/seller_details_bloc.dart';
import 'package:meer_flutter/presentation/seller_details/screen/seller_details_screen.dart';
import 'package:meer_flutter/presentation/seller_orders/bloc/seller_orders_bloc.dart';
import 'package:meer_flutter/presentation/seller_orders/screen/seller_orders_screen.dart';
import 'package:meer_flutter/presentation/seller_products/bloc/seller_products_bloc.dart';
import 'package:meer_flutter/presentation/seller_products/screen/seller_products_screen.dart';
import 'package:meer_flutter/presentation/seller_setup/bloc/seller_setup_bloc.dart';
import 'package:meer_flutter/presentation/seller_setup/screen/seller_setup_screen.dart';
import 'package:meer_flutter/repository/product_repository.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String? finalRouteName = settings.name;

    // تطبيق منطق الـ Middleware عند الدخول للتطبيق

    if (finalRouteName == AppRoute.loginScreen && client.auth.isAuthenticated) {
      finalRouteName = AppRoute.mainScreen;
    } else if (finalRouteName == AppRoute.mainScreen &&
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
      case AppRoute.mainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<MainBloc>(),
            child: const MainScreen(),
          ),
        );
      case AppRoute.sellerProductsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                sl<SellerProductsBloc>()
                  ..add(const SellerProductsEvent.started()),
            child: const SellerProductsScreen(),
          ),
        );
      case AppRoute.sellerSetupScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => sl<SellerSetupBloc>(),
            child: const SellerSetupScreen(),
          ),
        );
      case AppRoute.productFormScreen:
        final argument = settings.arguments;
        final productToEdit = argument is Product ? argument : null;

        return MaterialPageRoute<bool?>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ProductFormBloc(
              sl<ProductRepository>(),
              productToEdit: productToEdit,
            ),
            child: ProductFormScreen(
              productToEdit: productToEdit,
            ),
          ),
        );
      case AppRoute.sellerDetailsScreen:
        final sellerId = settings.arguments as int;

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => sl<SellerDetailsBloc>()
              ..add(
                SellerDetailsEvent.loadRequested(
                  sellerId: sellerId,
                ),
              ),
            child: SellerDetailsScreen(
              sellerId: sellerId,
            ),
          ),
        );

      case AppRoute.productDetailsScreen:
        final argument = settings.arguments;

        if (argument is! Product) {
          return null;
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProductDetailsScreen(
            product: argument,
          ),
        );

      case AppRoute.cartScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CartScreen(),
        );
      case AppRoute.checkoutScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => sl<CheckoutBloc>(),
            child: const CheckoutScreen(),
          ),
        );
      case AppRoute.sellerOrdersScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => sl<SellerOrdersBloc>()
              ..add(
                const SellerOrdersEvent.loadRequested(),
              ),
            child: const SellerOrdersScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
