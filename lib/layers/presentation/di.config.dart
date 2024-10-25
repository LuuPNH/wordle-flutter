// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../data/source/local/local_storage.dart' as _i80;
import '../data/source/network/api.dart' as _i1035;
import '../data/source/word_repository_impl.dart' as _i757;
import '../domain/repository/word_repository.dart' as _i176;
import '../domain/usecase/get_word_usecase.dart' as _i611;
import '../domain/usecase/random_word_usecase.dart' as _i236;
import 'di.dart' as _i913;
import 'home/home_bloc.dart' as _i170;
import 'home/play_game/bloc/play_game_bloc.dart' as _i623;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i170.HomeBloc>(() => _i170.HomeBloc());
    gh.singletonAsync<_i460.SharedPreferences>(
        () => registerModule.sharedPreferences);
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i1035.Api>(() => _i1035.ApiImpl(dio: gh<_i361.Dio>()));
    gh.singletonAsync<_i80.LocalStorage>(() async => _i80.LocalStorageImpl(
        sharedPreferences: await getAsync<_i460.SharedPreferences>()));
    gh.singletonAsync<_i176.WordRepository>(
        () async => _i757.WordRepositoryImpl(
              api: gh<_i1035.Api>(),
              localStorage: await getAsync<_i80.LocalStorage>(),
            ));
    gh.singletonAsync<_i236.GuessWordUsecase>(() async =>
        _i236.GuessWordUsecase(
            repository: await getAsync<_i176.WordRepository>()));
    gh.lazySingletonAsync<_i611.GetWordUsecase>(() async =>
        _i611.GetWordUsecase(
            repository: await getAsync<_i176.WordRepository>()));
    gh.factoryAsync<_i623.PlayGameBloc>(() async => _i623.PlayGameBloc(
          await getAsync<_i236.GuessWordUsecase>(),
          await getAsync<_i611.GetWordUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i913.RegisterModule {}
