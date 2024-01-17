// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetItInjectorGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:_domain/models/dio.dart' as i0;
import 'package:_domain/repo_interfaces/user_data_source.dart' as i1;
import 'package:_data/repos/user_data_source_impl.dart' as i2;
import 'package:_domain/repo_interfaces/user_cache.dart' as i3;
import 'package:_domain/repo_interfaces/user_repo.dart' as i4;
import 'package:_data/repos/user_repo_impl.dart' as i5;
import 'package:_data/repos/user_cache_impl.dart' as i6;

extension GetItX on GetIt {
  void init() {
    _registerCache();
    _registerDataSource();
    _registerRepo();
  }

  void _registerCache() {
    registerLazySingleton<i3.UserCache>(() => i6.UserCacheImpl());
  }

  void _registerDataSource() {
    registerFactory<i1.UserDataSource>(
        () => i2.UserDataSourceImpl(dio: get<i0.Dio>()));
  }

  void _registerRepo() {
    registerFactory<i4.UserRepo>(() => i5.UserRepoImpl(
          userDataSource: get<i1.UserDataSource>(),
          userCache: get<i3.UserCache>(),
        ));
  }
}
