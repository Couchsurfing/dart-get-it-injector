// --- LICENSE ---
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
// --- LICENSE ---
import 'package:change_case/change_case.dart';
import 'package:code_builder/code_builder.dart' hide Parameter;
import 'package:get_it_injector/get_it_injector.dart' show RegisterType;
import 'package:get_it_injector_gen/models/group.dart';
import 'package:get_it_injector_gen/models/importable.dart';
import 'package:get_it_injector_gen/models/injectable.dart';
import 'package:get_it_injector_gen/models/parameter.dart';
import 'package:get_it_injector_gen/src/models/named_import.dart';

Map<String, NamedImport> _indexedImports = {};

List<Spec> writeConfig(List<Injectable> injectables) {
  final allImports = injectables.expand((e) => e.imports).toSet().toList();

  _indexedImports = <String, NamedImport>{};
  for (final import in allImports) {
    _indexedImports[import] = NamedImport(import);
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
List<Spec> _writeImports(Iterable<NamedImport> imports) {
  final directives = imports
      .map(
        (e) => Directive.import(
          e.import,
          as: e.namespace,
        ),
      )
      .toList();

  directives.sort((a, b) => a.url.compareTo(b.url));

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
    if (injectable.group case final group?) {
      (groupedInjectables[group] ??= []).add(injectable);
    } else {
      nonGroupedInjectables.add(injectable);
    }
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
  final register = switch (injectable.registerType) {
    RegisterType.factory => 'registerFactory',
    RegisterType.singleton => 'registerSingleton',
    RegisterType.lazySingleton => 'registerLazySingleton',
  };

  final registerable = switch (injectable.registerType) {
    RegisterType.singleton => _writeSingleton(injectable),
    RegisterType.factory ||
    RegisterType.lazySingleton =>
      _writeFactory(injectable),
  };

  if (injectable.implementsOne) {
    return refer(register).call(
      [registerable],
      {},
      [
        if (injectable.implementations.single case final value)
          refer(allocate(value)),
      ],
    ).statement;
  } else {
    return Block.of([
      refer(register).call([registerable], {}, []).statement,
      for (final implementation in injectable.implementations)
        refer(register).call([
          switch (refer('get').call([], {}, [refer(allocate(injectable))])) {
            final value
                when injectable.registerType == RegisterType.singleton =>
              value,
            final value => value.lambda,
          }
        ], {}, [
          refer(allocate(implementation)),
        ]).statement,
    ]);
  }
}

extension _ExpressionX on Expression {
  Expression get lambda => Method(
        (p) => p
          ..lambda = true
          ..body = code,
      ).closure;
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
  final indexedImport = _indexedImports[element.import];

  if (indexedImport == null) {
    throw Exception('Unknown import: ${element.import}');
  }

  return '${indexedImport.namespace}.${element.type}';
}
