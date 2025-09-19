// --- LICENSE ---
/**
Copyright 2025 CouchSurfing International Inc.

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
// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:get_it_injector/get_it_injector.dart'
    show Priority, RegisterType;
import 'package:get_it_injector_gen/enums/parameter_type.dart';
import 'package:get_it_injector_gen/models/group.dart';
import 'package:get_it_injector_gen/models/implementation.dart';
import 'package:get_it_injector_gen/models/injectable.dart';
import 'package:get_it_injector_gen/models/parameter.dart';

class InjectableElement {
  const InjectableElement({
    required this.element,
    required this.implementations,
    required this.constructor,
    required this.priority,
    required this.group,
    required this.registerType,
    required this.ignoreForFile,
  });

  final ClassElement2 element;
  final List<InterfaceElement2> implementations;
  final ConstructorElement2 constructor;
  final Priority priority;
  final Group? group;
  final RegisterType registerType;
  final List<String> ignoreForFile;

  String toJson() {
    final injectable = Injectable(
      type: element.name3 ?? '',
      import: element.library2.identifier,
      implementations: [
        for (final impl in implementations)
          Implementation(
            type: impl.name3 ?? '',
            import: impl.library2.identifier,
          ),
      ],
      constructor: switch (constructor.name3) {
        'new' || null => '',
        final name => name,
      },
      parameters: constructor.formalParameters.map(_buildParameter).toList(),
      priority: priority.value,
      group: group,
      registerType: registerType,
      ignoreForFile: ignoreForFile,
    );

    return jsonEncode(injectable);
  }
}

Parameter _buildParameter(FormalParameterElement param) {
  final type = param.type;
  final isRequired = param.isRequiredNamed || param.isRequiredPositional;
  final defaultValue = param.defaultValueCode;
  final location = param.isNamed
      ? ParameterType.named
      : ParameterType.positional;

  final import = switch (type) {
    DartType(:final alias?) => alias.element2.library2.identifier,
    DartType(element3: Element2(:final library2?)) => library2.identifier,
    _ => null,
  };

  if (import == null) {
    throw Exception('''Failed to find import!
Type: ${type.getDisplayString()}
Param: ${param.displayName}
Parent: ${param.enclosingElement2?.displayName ?? 'Unknown'}
      ''');
  }

  final typeName = switch (type) {
    DartType(:final alias?) => alias.element2.displayName,
    _ => type.getDisplayString(),
  };

  return Parameter(
    name: param.name3 ?? '',
    type: typeName,
    isRequired: isRequired,
    defaultValue: defaultValue,
    location: location,
    import: import,
    parameters: param.formalParameters.map(_buildParameter).toList(),
  );
}
