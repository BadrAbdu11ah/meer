import 'package:get_it/get_it.dart';
// import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/services/app_service.dart';
import 'package:meer_flutter/core/storage/hive/hive_service.dart';
import 'package:meer_flutter/presentation/account/bloc/account_bloc.dart';
import 'package:meer_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/bloc/verify_otp_bloc.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/checkout/bloc/checkout_bloc.dart';
import 'package:meer_flutter/presentation/customer_orders/bloc/customer_orders_bloc.dart';
import 'package:meer_flutter/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:meer_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:meer_flutter/presentation/main/bloc/main_bloc.dart';
import 'package:meer_flutter/presentation/product_form/bloc/product_form_bloc.dart';
import 'package:meer_flutter/presentation/search/bloc/search_bloc.dart';
import 'package:meer_flutter/presentation/seller_details/bloc/seller_details_bloc.dart';
import 'package:meer_flutter/presentation/seller_orders/bloc/seller_orders_bloc.dart';
import 'package:meer_flutter/presentation/seller_products/bloc/seller_products_bloc.dart';
import 'package:meer_flutter/presentation/seller_setup/bloc/seller_setup_bloc.dart';
// import 'package:meer_flutter/presentation/search/bloc/search_bloc.dart';
import 'package:meer_flutter/repository/auth_repository.dart';
import 'package:meer_flutter/repository/local/cart_local_repository.dart';
import 'package:meer_flutter/repository/local/favorites_local_repository.dart';
import 'package:meer_flutter/repository/order_repository.dart';
import 'package:meer_flutter/repository/product_repository.dart';
import 'package:meer_flutter/repository/search_repository.dart';
import 'package:meer_flutter/repository/seller_repository.dart';

final sl = GetIt.instance; // sl تعني Service Locator

Future<void> initGetIt() async {
  // 1. Services (الأدوات الأساسية)
  sl.registerLazySingleton(() => AppService());

  // 2. Repositories
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(
    () => ProductRepository(),
  );
  sl.registerLazySingleton(() => SearchRepository());
  sl.registerLazySingleton(
    () => SellerRepository(),
  );
  sl.registerLazySingleton(
    () => OrderRepository(),
  );

  // 3. Local Repository
  sl.registerLazySingleton<CartLocalRepository>(
    () => CartLocalRepository(
      HiveService().cartBox,
    ),
  );

  sl.registerLazySingleton<FavoritesLocalRepository>(
    () => FavoritesLocalRepository(
      HiveService().favoritesBox,
    ),
  );

  // 4. Blocs

  // // 1. Auth Blocs
  sl.registerFactory(() => LoginBloc(sl<AuthRepository>()));
  sl.registerFactory(() => VerifyOtpBloc(sl<AuthRepository>()));

  // // 2. Main BloC
  sl.registerFactory(() => MainBloc());

  // // 3. Home BLoC
  sl.registerFactory(
    () => HomeBloc(sl<ProductRepository>()),
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
    () => SellerSetupBloc(sl<SellerRepository>()),
  );

  // // 7. Product Form BloC
  sl.registerFactory<ProductFormBloc>(
    () => ProductFormBloc(
      sl<ProductRepository>(),
    ),
  );

  // // 8. Seller Details BloC
  sl.registerFactory(
    () => SellerDetailsBloc(
      sl<SellerRepository>(),
      sl<ProductRepository>(),
    ),
  );

  // // 9. Cart BloC
  // استعادة السلة قبل بدء التطبيق.
  final savedCartItems = await sl<CartLocalRepository>().loadItems();

  // Cart Bloc: نسخة واحدة مشتركة على مستوى التطبيق.
  sl.registerLazySingleton<CartBloc>(
    () => CartBloc(
      sl<CartLocalRepository>(),
      initialItems: savedCartItems,
    ),
  );

  // // 10. Checkout BloC
  sl.registerFactory(
    () => CheckoutBloc(
      sl<OrderRepository>(),
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

  // // 13. Account BloC
  sl.registerFactory(
    () => AccountBloc(
      sl<SellerRepository>(),
    ),
  );

  // // 14. Favorites BloC
  final savedFavorites = await sl<FavoritesLocalRepository>().loadFavorites();

  sl.registerLazySingleton<FavoritesBloc>(
    () => FavoritesBloc(
      sl<FavoritesLocalRepository>(),
      initialFavorites: savedFavorites,
    ),
  );
}
