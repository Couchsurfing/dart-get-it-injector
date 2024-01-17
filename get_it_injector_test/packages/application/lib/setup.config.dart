// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetItInjectorGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:_domain/repo_interfaces/user_repo.dart' as i0;
import 'package:_application/blocs/user_bloc.dart' as i1;

extension GetItX on GetIt {
  void init() {
    registerFactory(() => i1.UserBloc(userRepo: get<i0.UserRepo>()));
  }
}
