import 'package:_domain/domain.dart';

class UserRepoImpl implements UserRepo {
  const UserRepoImpl({
    required UserDataSource userDataSource,
    required UserCache userCache,
  })  : _userDataSource = userDataSource,
        _userCache = userCache;

  final UserDataSource _userDataSource;
  final UserCache _userCache;
}
