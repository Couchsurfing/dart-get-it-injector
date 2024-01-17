import 'package:get_it_injector_core/enums/parameter_type.dart';
import 'package:get_it_injector_core/models/importable.dart';
import 'package:get_it_injector_core/models/parameters.dart';
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
  final String? import;
  final List<Parameter> parameters;

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}
