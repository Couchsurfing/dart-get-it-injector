// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetItInjectorGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:a/test/inputs/test_8/multi.dart' as i_multi;
import 'package:a/test/inputs/test_8/one.dart' as i_one;
import 'package:a/test/inputs/test_8/two.dart' as i_two;

extension GetItX on GetIt {
  void init() {
    registerLazySingleton(() => i_multi.Multi());
    registerLazySingleton<i_one.One>(() => get<i_multi.Multi>());
    registerLazySingleton<i_two.Two>(() => get<i_multi.Multi>());
  }
}
