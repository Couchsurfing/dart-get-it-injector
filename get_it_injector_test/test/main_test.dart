import 'package:_application/blocs/user_bloc.dart';
import 'package:_application/setup.dart' as application;
import 'package:_data/setup.dart' as data;
import 'package:_domain/domain.dart';
import 'package:_typedef/setup.dart' as td;
import 'package:_typedef/type_def.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

void main() {
  group('Data', () {
    late GetIt getIt;
    setUp(() {
      getIt = GetIt.asNewInstance();
      data.setup(getIt);
    });

    tearDown(() {
      getIt.reset();
    });

    test('Verify that everything is registered', () {
      expect(getIt.isRegistered<UserCache>(), isTrue);
      expect(getIt.isRegistered<UserDataSource>(), isTrue);
      expect(getIt.isRegistered<UserRepo>(), isTrue);
    });
  });

  group('Application', () {
    late GetIt getIt;
    setUp(() {
      getIt = GetIt.asNewInstance();
      data.setup(getIt);
      application.setup(getIt);
    });

    tearDown(() {
      getIt.reset();
    });

    test('Verify that everything is registered', () {
      expect(getIt.isRegistered<UserBloc>(), isTrue);
    });
  });

  group('typedefs', () {
    late GetIt getIt;

    setUp(() {
      getIt = GetIt.asNewInstance();
      td.setup(getIt);
    });

    tearDown(() {
      getIt.reset();
    });

    test('Verify that everything is registered', () {
      expect(
        getIt.isRegistered<LegendOfZeldaRepoConsumer>(),
        isTrue,
        reason: 'LegendOfZeldaRepoConsumer is registered',
      );

      expect(
        getIt.isRegistered<LegendOfZeldaRepo>(),
        isTrue,
        reason: 'LegendOfZeldaRepo is registered',
      );
    });
  });
}
