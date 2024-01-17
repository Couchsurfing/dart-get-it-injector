import 'package:json_annotation/json_annotation.dart';
import 'package:get_it_injector/get_it_injector.dart' as annotations
    show RegisterType;

@JsonEnum(fieldRename: FieldRename.snake)
enum RegisterType {
  factory(annotations.RegisterType.factory),
  singleton(annotations.RegisterType.singleton),
  lazySingleton(annotations.RegisterType.lazySingleton);

  const RegisterType(this.annotationValue);

  final annotations.RegisterType annotationValue;
}
