import 'package:_domain/domain.dart';

class UserDataSourceImpl implements UserDataSource {
  const UserDataSourceImpl({
    required this.dio,
  });

  final Dio dio;
}
