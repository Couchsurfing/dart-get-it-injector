// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parameter _$ParameterFromJson(Map json) => Parameter(
  name: json['name'] as String,
  type: json['type'] as String,
  isRequired: json['is_required'] as bool,
  defaultValue: json['default_value'] as String?,
  location: $enumDecode(_$ParameterTypeEnumMap, json['location']),
  import: json['import'] as String,
  parameters: (json['parameters'] as List<dynamic>)
      .map((e) => Parameter.fromJson(e as Map))
      .toList(),
);

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
  'name': instance.name,
  'type': instance.type,
  'is_required': instance.isRequired,
  'default_value': instance.defaultValue,
  'location': _$ParameterTypeEnumMap[instance.location]!,
  'import': instance.import,
  'parameters': instance.parameters.map((e) => e.toJson()).toList(),
};

const _$ParameterTypeEnumMap = {
  ParameterType.named: 'named',
  ParameterType.positional: 'positional',
};
