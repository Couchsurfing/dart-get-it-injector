// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map json) => Settings.defaults(
      registerAsImplementation:
          json['register_as_implementation'] as bool? ?? false,
      priorities: (json['priorities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      groups: (json['groups'] as Map?)?.map(
            (k, e) => MapEntry(k as String,
                (e as List<dynamic>).map((e) => e as String).toList()),
          ) ??
          const {},
      factories: (json['factories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lazySingletons: (json['lazy_singletons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      singletons: (json['singletons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      registerDefault: $enumDecodeNullable(
              _$RegisterTypeEnumMap, json['register_default']) ??
          RegisterType.factory,
      autoRegister: json['auto_register'] as bool? ?? false,
      register: (json['register'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      doNotRegister: (json['do_not_register'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      ignoreForFile: (json['ignore_for_file'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'auto_register': instance.autoRegister,
      'factories': instance.factories,
      'groups': instance.groups,
      'lazy_singletons': instance.lazySingletons,
      'priorities': instance.priorities,
      'register': instance.register,
      'do_not_register': instance.doNotRegister,
      'register_as_implementation': instance.registerAsImplementation,
      'register_default': _$RegisterTypeEnumMap[instance.registerDefault]!,
      'singletons': instance.singletons,
      'ignore_for_file': instance.ignoreForFile,
    };

const _$RegisterTypeEnumMap = {
  RegisterType.factory: 'factory',
  RegisterType.singleton: 'singleton',
  RegisterType.lazySingleton: 'lazy_singleton',
};
