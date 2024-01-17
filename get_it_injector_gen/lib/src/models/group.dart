import 'package:analyzer/dart/constant/value.dart';
import 'package:get_it_injector/get_it_injector.dart';
import 'package:get_it_injector_core/get_it_injector_core.dart' as core;

class Group extends core.Group {
  const Group({
    required super.name,
    required super.priority,
  });

  factory Group.fromAnnotation(
    DartObject annotation,
    int? Function(String groupName) getPriority,
  ) {
    final name = annotation.getField('name')!.toStringValue()!;

    return Group(
      name: name,
      priority: getPriority(name) ?? lowPriority.value,
    );
  }
}
