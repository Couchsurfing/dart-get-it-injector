// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetItInjectorGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:a/test/inputs/test_1/repo.dart' as i0;
import 'package:a/test/inputs/test_1/repo_impl.dart' as i1;

extension GetItX on GetIt {
  void init() {
    registerFactory<i0.Repo>(() => i1.RepoImpl());
    registerFactory(() => i0.Repo());
  }
}
