import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di.config.dart';

GetIt getIt = GetIt.instance;

@module
abstract class RegisterModule {
  @singleton
  Future<SharedPreferences> get sharedPreferences async =>
      await SharedPreferences.getInstance();

  @singleton
  Dio get dio => Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)));
}

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureInjection() async {
  getIt.init();
  await getIt.allReady(timeout: const Duration(seconds: 5));
}
