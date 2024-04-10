// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetItInjectorGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:_domain/repo_interfaces/user_repo.dart' as i_user_repo;
import 'package:_application/blocs/user_bloc.dart' as i_user_bloc;

extension GetItX on GetIt {
  void init() {
    registerFactory(
        () => i_user_bloc.UserBloc(userRepo: get<i_user_repo.UserRepo>()));
  }
}
