import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:get_it_injector/get_it_injector.dart'
    show Priority, RegisterType;
import 'package:get_it_injector_gen/enums/parameter_type.dart';
import 'package:get_it_injector_gen/models/implementation.dart';
import 'package:get_it_injector_gen/models/injectable.dart';
import 'package:get_it_injector_gen/models/parameter.dart';
import 'package:get_it_injector_gen/models/group.dart';

class InjectableElement {
  const InjectableElement({
    required this.element,
    required this.implementation,
    required this.constructor,
    required this.priority,
    required this.group,
    required this.registerType,
    required this.ignoreForFile,
  });

  final ClassElement element;
  final InterfaceElement? implementation;
  final ConstructorElement constructor;
  final Priority priority;
  final Group? group;
  final RegisterType registerType;
  final List<String> ignoreForFile;

  String toJson() {
    final impl = implementation;

    final injectable = Injectable(
      type: element.name,
      import: element.library.identifier,
      implementation: impl != null
          ? Implementation(
              type: impl.name,
              import: impl.library.identifier,
            )
          : null,
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

  return Parameter(
    name: param.name,
    type: type.getDisplayString(withNullability: false),
    isRequired: isRequired,
    defaultValue: defaultValue,
    location: location,
    import: type.element?.library?.identifier,
    parameters: param.parameters.map(_buildParameter).toList(),
  );
}
