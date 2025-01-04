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
import 'package:get_it_injector/get_it_injector.dart' show RegisterType;
import 'package:get_it_injector_gen/models/group.dart';
import 'package:get_it_injector_gen/models/implementation.dart';
import 'package:get_it_injector_gen/models/importable.dart';
import 'package:get_it_injector_gen/models/parameter.dart';
import 'package:get_it_injector_gen/models/parameters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'injectable.g.dart';

@JsonSerializable()
class Injectable with Parameters implements Importable {
  const Injectable({
    required this.type,
    required this.import,
    required this.implementations,
    required this.constructor,
    required this.parameters,
    required this.priority,
    required this.group,
    required this.registerType,
    required this.ignoreForFile,
  });

  factory Injectable.fromJson(Map json) => _$InjectableFromJson(json);

  final String type;
  final String import;
  @JsonKey(defaultValue: [])
  final List<Implementation> implementations;
  final String constructor;
  final List<Parameter> parameters;
  final int priority;
  final Group? group;
  final RegisterType registerType;
  final List<String> ignoreForFile;

  bool get implementsOne => implementations.length == 1;
  bool get implementsMany => implementations.length > 1;

  String get constructorAccess => constructor == '' ? '' : '.$constructor';

  Iterable<String> get imports => [
        ...parameterImports,
        for (final implementation in implementations)
          if (implementation.import case final String value) value,
        import,
      ];

  Map<String, dynamic> toJson() => _$InjectableToJson(this);
}
