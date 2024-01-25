/**
Copyright 2024 CouchSurfing International Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 */
import 'package:_application/blocs/user_bloc.dart';
import 'package:_application/setup.dart' as application;
import 'package:_domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:_data/setup.dart' as data;
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
}
