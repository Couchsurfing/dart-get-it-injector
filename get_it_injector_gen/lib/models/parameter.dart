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
import 'package:get_it_injector_gen/enums/parameter_type.dart';
import 'package:get_it_injector_gen/models/importable.dart';
import 'package:get_it_injector_gen/models/parameters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parameter.g.dart';

@JsonSerializable()
class Parameter with Parameters implements Importable {
  const Parameter({
    required this.name,
    required this.type,
    required this.isRequired,
    required this.defaultValue,
    required this.location,
    required this.import,
    required this.parameters,
  });

  factory Parameter.fromJson(Map json) => _$ParameterFromJson(json);

  final String name;
  final String type;
  final bool isRequired;
  final String? defaultValue;
  final ParameterType location;
  final String import;
  final List<Parameter> parameters;

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}
