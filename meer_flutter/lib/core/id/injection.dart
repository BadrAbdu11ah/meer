import 'package:get_it/get_it.dart';
import 'package:meer_flutter/core/services/app_service.dart';
import 'package:meer_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/bloc/verify_otp_bloc.dart';
import 'package:meer_flutter/repository/auth_repository.dart';

final sl = GetIt.instance; // sl تعني Service Locator

Future<void> initGetIt() async {
  // 1. Services (الأدوات الأساسية)
  sl.registerLazySingleton(() => AppService());

  // 2. Repositories
  sl.registerLazySingleton(() => AuthRepository());

  // 3. Blocs

  // // Auth Blocs
  sl.registerFactory(() => LoginBloc(sl<AuthRepository>()));
  sl.registerFactory(() => VerifyOtpBloc(sl<AuthRepository>()));
}
