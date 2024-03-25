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
import 'package:get_it_injector_gen/models/importable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'implementation.g.dart';

@JsonSerializable()
class Implementation implements Importable {
  const Implementation({
    required this.type,
    required this.import,
  });

  factory Implementation.fromJson(Map<String, dynamic> json) =>
      _$ImplementationFromJson(json);

  final String type;
  final String import;

  Map<String, dynamic> toJson() => _$ImplementationToJson(this);
}
