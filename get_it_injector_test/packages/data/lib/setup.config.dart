// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// GetItInjectorGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:_data/repos/user_cache_impl.dart' as i_user_cache_impl;
import 'package:_data/repos/user_data_source_impl.dart'
    as i_user_data_source_impl;
import 'package:_data/repos/user_repo_impl.dart' as i_user_repo_impl;
import 'package:_domain/models/dio.dart' as i_dio;
import 'package:_domain/repo_interfaces/user_cache.dart' as i_user_cache;
import 'package:_domain/repo_interfaces/user_data_source.dart'
    as i_user_data_source;
import 'package:_domain/repo_interfaces/user_repo.dart' as i_user_repo;

extension GetItX on GetIt {
  void init() {
    _registerCache();
    _registerDataSource();
    _registerRepo();
  }

  void _registerCache() {
    registerLazySingleton<i_user_cache.UserCache>(
      () => i_user_cache_impl.UserCacheImpl(),
    );
  }

  void _registerDataSource() {
    registerFactory<i_user_data_source.UserDataSource>(
      () => i_user_data_source_impl.UserDataSourceImpl(dio: get<i_dio.Dio>()),
    );
  }

  void _registerRepo() {
    registerFactory<i_user_repo.UserRepo>(
      () => i_user_repo_impl.UserRepoImpl(
        userDataSource: get<i_user_data_source.UserDataSource>(),
        userCache: get<i_user_cache.UserCache>(),
      ),
    );
  }
}
