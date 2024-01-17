import 'package:analyzer/dart/constant/value.dart';
import 'package:get_it_injector/get_it_injector.dart' as annotations;

class Priority implements annotations.Priority {
  const Priority(this.value);

  final int value;

  factory Priority.fromAnnotation(DartObject annotation) {
    return Priority(annotation.getField('value')!.toIntValue()!);
  }
}
