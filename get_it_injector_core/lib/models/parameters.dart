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
import 'package:get_it_injector_core/enums/parameter_type.dart';
import 'package:get_it_injector_core/models/parameter.dart';

abstract mixin class Parameters {
  List<Parameter> get parameters;

  List<Parameter> get positionalParameters =>
      parameters.where((e) => e.location == ParameterType.positional).toList();

  List<Parameter> get namedParameters =>
      parameters.where((e) => e.location == ParameterType.named).toList();

  List<String> get parameterImports => parameters
      .map(_parameterImports)
      .expand((e) => e)
      .whereType<String>()
      .toList();

  Iterable<String?> _parameterImports(Parameter param) sync* {
    yield param.import;

    for (final p in param.parameters) {
      yield* _parameterImports(p);
    }
  }
}
