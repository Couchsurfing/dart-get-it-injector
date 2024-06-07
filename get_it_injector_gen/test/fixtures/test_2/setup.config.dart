// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetItInjectorGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:a/test/inputs/test_1/repo.dart' as i_repo;
import 'package:a/test/inputs/test_1/repo_impl.dart' as i_repo_impl;

extension GetItX on GetIt {
  void init() {
    registerFactory(() => i_repo.Repo());
    registerFactory<i_repo.Repo>(() => i_repo_impl.RepoImpl());
  }
}
