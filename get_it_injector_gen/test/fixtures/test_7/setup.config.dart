// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetItInjectorGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:a/test/inputs/test_7/multi.dart' as i_multi;
import 'package:a/test/inputs/test_7/one.dart' as i_one;
import 'package:a/test/inputs/test_7/two.dart' as i_two;

extension GetItX on GetIt {
  void init() {
    registerFactory(() => i_multi.Multi());
    registerFactory<i_one.One>(() => get<i_multi.Multi>());
    registerFactory<i_two.Two>(() => get<i_multi.Multi>());
  }
}
