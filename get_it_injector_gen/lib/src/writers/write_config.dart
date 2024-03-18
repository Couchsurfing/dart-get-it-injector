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
import 'package:change_case/change_case.dart';
import 'package:code_builder/code_builder.dart' hide Parameter;
import 'package:get_it_injector/get_it_injector.dart' show RegisterType;
import 'package:get_it_injector_gen/models/group.dart';
import 'package:get_it_injector_gen/models/importable.dart';
import 'package:get_it_injector_gen/models/injectable.dart';
import 'package:get_it_injector_gen/models/parameter.dart';
import 'package:get_it_injector_gen/src/models/indexed_import.dart';

Map<String, IndexedImport> _indexedImports = {};

List<Spec> writeConfig(List<Injectable> injectables) {
  final allImports = injectables.expand((e) => e.imports).toSet().toList();

  _indexedImports = <String, IndexedImport>{};
  for (var i = 0; i < allImports.length; i++) {
    final import = allImports[i];

    _indexedImports[import] = IndexedImport(
      import: import,
      index: i,
    );
  }

  final allIgnores =
      injectables.expand((e) => e.ignoreForFile).toSet().toList();

  final ignore = _writeIgnores(allIgnores);
  final import = _writeImports(_indexedImports.values);
  final extension = _writeExtension(injectables);

  return [
    ...ignore,
    ...import,
    extension,
  ];
}

List<Code> _writeIgnores(Iterable<String> ignores) {
  if (ignores.isEmpty) return [];

  return [
    Code('// ignore: lines_longer_than_80_chars'),
    Code('// ignore_for_file: ${ignores.join(',')}'),
  ];
}

// get_it/get_it.dart
List<Spec> _writeImports(Iterable<IndexedImport> imports) {
  final directives = imports.map(
    (e) => Directive.import(
      e.import,
      as: e.namespace,
    ),
  );

  return [
    Directive.import('package:get_it/get_it.dart'),
    ...directives,
  ];
}

Extension _writeExtension(
  List<Injectable> injectables,
) {
  final groupedInjectables = <Group, List<Injectable>>{};
  final nonGroupedInjectables = <Injectable>[];

  for (final injectable in injectables) {
    if (injectable.group == null) {
      nonGroupedInjectables.add(injectable);
      continue;
    }

    groupedInjectables.putIfAbsent(injectable.group!, () => []).add(injectable);
  }

  final sortedGroupedInjectables = groupedInjectables.keys.toList()
    ..sort((a, b) => b.priority.compareTo(a.priority));

  return Extension(
    (b) => b
      ..name = 'GetItX'
      ..on = refer('GetIt')
      ..methods.addAll([
        Method.returnsVoid(
          (b) => b
            ..name = 'init'
            ..body = Block(
              (b) => b
                ..statements.addAll(
                  sortedGroupedInjectables.map((e) =>
                      refer('_register${e.name.toPascalCase()}')
                          .call([]).statement),
                )
                ..statements.addAll(
                  nonGroupedInjectables.map(
                    (e) => _writeInjectable(e),
                  ),
                ),
            ),
        ),
        ...sortedGroupedInjectables.map(
          (e) => _writeGroupedInjectables(e, groupedInjectables[e]!),
        ),
      ]),
  );
}

Method _writeGroupedInjectables(
  Group group,
  List<Injectable> injectables,
) {
  final sortedInjectables = injectables.toList()
    ..sort(
      (a, b) => a.priority.compareTo(b.priority),
    );

  return Method.returnsVoid(
    (b) => b
      ..name = '_register${group.name.toPascalCase()}'
      ..body = Block(
        (b) => b
          ..statements.addAll(
            sortedInjectables.map(
              (e) => _writeInjectable(e),
            ),
          ),
      ),
  );
}

Code _writeInjectable(
  Injectable injectable,
) {
  if (injectable.registerType == RegisterType.singleton) {
    return refer('registerSingleton').call(
      [_writeSingleton(injectable)],
      {},
      [
        if (injectable.implementation != null)
          refer(allocate(injectable.implementation!)),
      ],
    ).statement;
  } else if (injectable.registerType == RegisterType.factory ||
      injectable.registerType == RegisterType.lazySingleton) {
    final call = injectable.registerType == RegisterType.factory
        ? 'registerFactory'
        : 'registerLazySingleton';

    return refer(call).call(
      [_writeFactory(injectable)],
      {},
      [
        if (injectable.implementation != null)
          refer(allocate(injectable.implementation!)),
      ],
    ).statement;
  }

  throw Exception('Unknown register type: ${injectable.registerType}');
}

Expression _writeFactory(
  Injectable injectable,
) {
  return Method(
    (b) => b
      ..lambda = true
      ..body = Block((b) => b
        // make new call to .type
        ..statements.add(
          _writeInvocation(injectable).code,
        )),
  ).closure;
}

Expression _writeSingleton(
  Injectable injectable,
) {
  return _writeInvocation(injectable);
}

Expression _writeInvocation(Injectable injectable) {
  return refer('${allocate(injectable)}${injectable.constructorAccess}')
      .newInstance(
    [
      ...injectable.positionalParameters.map(_writeParameter),
    ],
    {
      for (final param in injectable.namedParameters)
        param.name: _writeParameter(param),
    },
  );
}

Expression _writeParameter(
  Parameter param,
) {
  return refer('get').newInstance(
    [
      ...param.positionalParameters.map(_writeParameter),
    ],
    {
      for (final param in param.namedParameters)
        param.name: _writeParameter(param),
    },
    [refer(allocate(param))],
  );
}

String allocate(Importable element) {
  final indexedImport = _indexedImports[element.import]!;

  return '${indexedImport.namespace}.${element.type}';
}
