import 'package:get_it/get_it.dart';
// import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/services/app_service.dart';
import 'package:meer_flutter/core/services/notification_navigation_service.dart';
import 'package:meer_flutter/core/services/notification_registration_service.dart';
import 'package:meer_flutter/core/services/notification_service.dart';
import 'package:meer_flutter/core/services/location_service.dart';
import 'package:meer_flutter/presentation/account/bloc/account_bloc.dart';
import 'package:meer_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/bloc/verify_otp_bloc.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/checkout/bloc/checkout_bloc.dart';
import 'package:meer_flutter/presentation/customer_orders/bloc/customer_orders_bloc.dart';
import 'package:meer_flutter/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:meer_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:meer_flutter/presentation/main/bloc/main_bloc.dart';
import 'package:meer_flutter/presentation/order_details/bloc/order_details_bloc.dart';
import 'package:meer_flutter/presentation/product_form/bloc/product_form_bloc.dart';
import 'package:meer_flutter/presentation/search/bloc/search_bloc.dart';
import 'package:meer_flutter/presentation/seller_details/bloc/seller_details_bloc.dart';
import 'package:meer_flutter/presentation/seller_orders/bloc/seller_orders_bloc.dart';
import 'package:meer_flutter/presentation/seller_products/bloc/seller_products_bloc.dart';
import 'package:meer_flutter/presentation/seller_setup/bloc/seller_setup_bloc.dart';
import 'package:meer_flutter/repository/auth_repository.dart';
import 'package:meer_flutter/repository/cart_repository.dart';
import 'package:meer_flutter/repository/favorites_repository.dart';
import 'package:meer_flutter/repository/image_repository.dart';
import 'package:meer_flutter/repository/local/city_local_repository.dart';
import 'package:meer_flutter/repository/notification_repository.dart';
import 'package:meer_flutter/repository/order_repository.dart';
import 'package:meer_flutter/repository/product_repository.dart';
import 'package:meer_flutter/repository/search_repository.dart';
import 'package:meer_flutter/repository/seller_repository.dart';

final sl = GetIt.instance; // sl تعني Service Locator

Future<void> initGetIt() async {
  // 1. Services (الأدوات الأساسية)
  sl.registerLazySingleton(() => AppService());
  sl.registerLazySingleton<NotificationService>(
    () => NotificationService(),
    dispose: (service) => service.dispose(),
  );
  sl.registerLazySingleton<NotificationNavigationService>(
    () => NotificationNavigationService(
      notificationService: sl<NotificationService>(),
    ),
    dispose: (service) => service.dispose(),
  );
  // 2. Repositories
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(
    () => NotificationRepository(),
  );
  sl.registerLazySingleton(
    () => ProductRepository(),
  );
  sl.registerLazySingleton(() => CityLocalRepository());
  sl.registerLazySingleton(() => ImageRepository());
  sl.registerLazySingleton(() => LocationService());
  sl.registerLazySingleton(
    () => SearchRepository(sl<CityLocalRepository>()),
  );
  sl.registerLazySingleton(
    () => SellerRepository(),
  );
  sl.registerLazySingleton(
    () => OrderRepository(),
  );
  sl.registerLazySingleton(() => CartRepository());
  sl.registerLazySingleton(
    () => FavoritesRepository(),
  );

  // // Notification Registration Service
  sl.registerLazySingleton<NotificationRegistrationService>(
    () => NotificationRegistrationService(
      notificationService: sl<NotificationService>(),
      notificationRepository: sl<NotificationRepository>(),
      preferences: AppService().sharedPreferences,
    ),
    dispose: (service) => service.dispose(),
  );

  // 3. Blocs

  // // 1. Auth Blocs
  sl.registerFactory(() => LoginBloc(sl<AuthRepository>()));
  sl.registerFactory(() => VerifyOtpBloc(sl<AuthRepository>()));

  // // 2. Main BloC
  sl.registerFactory(() => MainBloc());

  // // 3. Home BLoC
  sl.registerFactory(
    () => HomeBloc(
      sl<ProductRepository>(),
      sl<CityLocalRepository>(),
      sl<LocationService>(),
    ),
  );

  // // 4. Search BloC
  sl.registerFactory(
    () => SearchBloc(sl<SearchRepository>()),
  );

  // // 5. Seller Products BloC
  sl.registerFactory(
    () => SellerProductsBloc(sl<ProductRepository>()),
  );

  // // 6. Seller Setup BloC
  sl.registerFactory(
    () => SellerSetupBloc(
      sl<SellerRepository>(),
      sl<LocationService>(),
    ),
  );

  // // 7. Product Form BloC
  sl.registerFactory<ProductFormBloc>(
    () => ProductFormBloc(
      sl<ProductRepository>(),
      sl<ImageRepository>(),
    ),
  );

  // // 8. Seller Details BloC
  sl.registerFactory(
    () => SellerDetailsBloc(
      sl<SellerRepository>(),
      sl<ProductRepository>(),
    ),
  );

  // 9. Cart Bloc
  sl.registerLazySingleton<CartBloc>(
    () => CartBloc(
      sl<CartRepository>(),
    ),
  );

  // // 10. Checkout BloC
  sl.registerFactory(
    () => CheckoutBloc(
      sl<OrderRepository>(),
      sl<SellerRepository>(),
      sl<LocationService>(),
      sl<AuthRepository>(),
    ),
  );

  // // 11. Customer Orders BloC
  sl.registerFactory(
    () => CustomerOrdersBloc(
      sl<OrderRepository>(),
    ),
  );

  // // 12. Seller Orders BloC
  sl.registerFactory(
    () => SellerOrdersBloc(
      sl<OrderRepository>(),
    ),
  );

  // // Order Details Bloc
  sl.registerFactory(
    () => OrderDetailsBloc(
      sl<OrderRepository>(),
    ),
  );

  // // 13. Account BloC
  sl.registerFactory(
    () => AccountBloc(
      sl<SellerRepository>(),
    ),
  );

  // // 14. Favorites Bloc
  sl.registerLazySingleton<FavoritesBloc>(
    () => FavoritesBloc(
      sl<FavoritesRepository>(),
    ),
  );
}
