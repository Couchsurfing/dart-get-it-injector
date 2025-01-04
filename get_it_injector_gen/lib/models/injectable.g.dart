// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injectable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Injectable _$InjectableFromJson(Map json) => Injectable(
      type: json['type'] as String,
      import: json['import'] as String,
      implementations: (json['implementations'] as List<dynamic>?)
              ?.map((e) =>
                  Implementation.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      constructor: json['constructor'] as String,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => Parameter.fromJson(e as Map))
          .toList(),
      priority: (json['priority'] as num).toInt(),
      group:
          json['group'] == null ? null : Group.fromJson(json['group'] as Map),
      registerType: $enumDecode(_$RegisterTypeEnumMap, json['register_type']),
      ignoreForFile: (json['ignore_for_file'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$InjectableToJson(Injectable instance) =>
    <String, dynamic>{
      'type': instance.type,
      'import': instance.import,
      'implementations':
          instance.implementations.map((e) => e.toJson()).toList(),
      'constructor': instance.constructor,
      'parameters': instance.parameters.map((e) => e.toJson()).toList(),
      'priority': instance.priority,
      'group': instance.group?.toJson(),
      'register_type': _$RegisterTypeEnumMap[instance.registerType]!,
      'ignore_for_file': instance.ignoreForFile,
    };

const _$RegisterTypeEnumMap = {
  RegisterType.factory: 'factory',
  RegisterType.singleton: 'singleton',
  RegisterType.lazySingleton: 'lazySingleton',
};
