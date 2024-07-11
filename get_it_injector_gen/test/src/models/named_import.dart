import 'package:get_it_injector_gen/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('$NamedImport', () {
    test('replaces non-alphanumeric characters with underscores', () {
      final namedImport = NamedImport('dart:core');

      expect(namedImport.namespace, 'i_dart_core');
    });
  });
}
