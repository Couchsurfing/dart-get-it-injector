import 'package:get_it_injector/get_it_injector.dart';

@factory
class PeopleRepositoryImpl extends Repository<User>
    implements PeopleRepository {}

class Repository<T> {
  Repository();
}

class PeopleRepository {}

class User {}
