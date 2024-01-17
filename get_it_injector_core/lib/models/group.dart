import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get_it_injector/get_it_injector.dart' as annotations;

part 'group.g.dart';

@autoequal
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
