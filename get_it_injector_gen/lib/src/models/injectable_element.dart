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
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
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

  final ClassElement element;
  final List<InterfaceElement> implementations;
  final ConstructorElement constructor;
  final Priority priority;
  final Group? group;
  final RegisterType registerType;
  final List<String> ignoreForFile;

  String toJson() {
    final injectable = Injectable(
      type: element.name,
      import: element.library.identifier,
      implementations: [
        for (final impl in implementations)
          Implementation(
            type: impl.name,
            import: impl.library.identifier,
          ),
      ],
      constructor: constructor.name,
      parameters: constructor.parameters.map(_buildParameter).toList(),
      priority: priority.value,
      group: group,
      registerType: registerType,
      ignoreForFile: ignoreForFile,
    );

    return jsonEncode(injectable);
  }
}

Parameter _buildParameter(ParameterElement param) {
  final type = param.type;
  final isRequired = param.isRequiredNamed || param.isRequiredPositional;
  final defaultValue = param.defaultValueCode;
  final location =
      param.isNamed ? ParameterType.named : ParameterType.positional;

  final import = type.element?.library?.identifier;

  if (import == null) {
    throw Exception(
      '''Failed to find import!
Type: ${type.getDisplayString(withNullability: false)}
Param: ${param.displayName}
Parent: ${param.enclosingElement?.displayName ?? 'Unknown'}
      ''',
    );
  }

  return Parameter(
    name: param.name,
    type: type.getDisplayString(withNullability: false),
    isRequired: isRequired,
    defaultValue: defaultValue,
    location: location,
    import: import,
    parameters: param.parameters.map(_buildParameter).toList(),
  );
}
