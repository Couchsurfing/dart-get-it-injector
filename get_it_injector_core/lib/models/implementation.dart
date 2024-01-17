import 'package:get_it_injector_core/models/importable.dart';
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
