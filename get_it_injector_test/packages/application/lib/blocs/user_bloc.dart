import 'package:_domain/domain.dart';

class UserBloc {
  const UserBloc({
    required UserRepo userRepo,
  }) : _userRepo = userRepo;

  final UserRepo _userRepo;
}
