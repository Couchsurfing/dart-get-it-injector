// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$GroupAutoequal on Group {
  List<Object?> get _$props => [
        name,
        priority,
      ];
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map json) => Group(
      name: json['name'] as String,
      priority: json['priority'] as int,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'name': instance.name,
      'priority': instance.priority,
    };
