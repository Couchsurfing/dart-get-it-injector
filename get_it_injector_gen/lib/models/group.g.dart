// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map json) => Group(
  name: json['name'] as String,
  priority: (json['priority'] as num).toInt(),
);

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
  'name': instance.name,
  'priority': instance.priority,
};
