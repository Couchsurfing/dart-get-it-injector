import 'package:get_it_injector/get_it_injector.dart' show RegisterType;
import 'package:get_it_injector_core/models/group.dart';
import 'package:get_it_injector_core/models/implementation.dart';
import 'package:get_it_injector_core/models/importable.dart';
import 'package:get_it_injector_core/models/parameter.dart';
import 'package:get_it_injector_core/models/parameters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'injectable.g.dart';

@JsonSerializable()
class Injectable with Parameters implements Importable {
  const Injectable({
    required this.type,
    required this.import,
    required this.implementation,
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
  final Implementation? implementation;
  final String constructor;
  final List<Parameter> parameters;
  final int priority;
  final Group? group;
  final RegisterType registerType;
  final List<String> ignoreForFile;

  String get constructorAccess => constructor == '' ? '' : '.$constructor';

  Iterable<String> get imports => [
        ...parameterImports,
        if (implementation != null) implementation!.import,
        import,
      ];

  Map<String, dynamic> toJson() => _$InjectableToJson(this);
}
