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
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get_it_injector/get_it_injector.dart' as annotations;

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable implements annotations.Group {
  const Group({
    required this.name,
    required this.priority,
  });

  factory Group.fromJson(Map json) => _$GroupFromJson(json);

  final String name;
  final int priority;

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object?> get props => _$props;
}
