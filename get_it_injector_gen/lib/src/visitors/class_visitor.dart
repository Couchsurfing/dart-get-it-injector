import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:get_it_injector/get_it_injector.dart' hide Group;
import 'package:get_it_injector_core/get_it_injector_core.dart';
import 'package:get_it_injector_gen/src/checkers/checkers.dart';
import 'package:get_it_injector_gen/src/models/models.dart' as gen;

class ClassVisitor extends RecursiveElementVisitor<void> {
  ClassVisitor(this.settings);

  final Settings settings;

  final List<gen.InjectableElement> nodes = [];

  @override
  void visitClassElement(ClassElement node) {
    if (ignoreChecker.hasAnnotationOf(node, throwOnUnresolved: false)) {
      return;
    }

    if (node.isPrivate) {
      return;
    }

    if (node.isAbstract) {
      return;
    }

    final ConstructorElement constructor = _getConstructor(node);
    final ClassElement? implementation = _getImplementation(node, settings);
    final Priority? priority = _getPriority(node, settings);
    final Group? group = _getGroup(node, settings);
    final RegisterType? registerType = _getRegisterType(node, settings);

    if (registerType == null && group == null && priority == null) {
      // Not registered as anything, skip
      return;
    }

    final element = gen.InjectableElement(
      element: node,
      implementation: implementation,
      constructor: constructor,
      priority: priority ?? settings.defaultPriority,
      group: group,
      registerType: registerType ?? settings.registerDefault.annotationValue,
      ignoreForFile: [...settings.ignoreForFile],
    );

    nodes.add(element);

    settings.ignoreForFile.clear();
  }
}

ClassElement? _getImplementation(ClassElement node, Settings settings) {
  if (!settings.registerAsImplementation) {
    return null;
  }

  // get declaration string
  final signature = '$node';

  // check source if implementation keyword is used
  if (!signature.contains('implements')) {
    return null;
  }

  // get class name of implementation from source
  final className = signature
      .substring(signature.indexOf('implements') + 'implements'.length)
      .split(' ')
      .where((e) => e.isNotEmpty)
      .first;

  for (final interface in node.interfaces) {
    if (interface.element is! ClassElement) {
      continue;
    }

    if (interface.element.name != className) {
      continue;
    }

    return interface.element as ClassElement;
  }

  return null;
}

Priority? _getPriority(ClassElement node, Settings settings) {
  final priorityAnnotation =
      priorityChecker.firstAnnotationOf(node, throwOnUnresolved: false);

  if (priorityAnnotation != null) {
    return gen.Priority.fromAnnotation(priorityAnnotation);
  }

  return settings.getPriorityForClass(node.name);
}

Group? _getGroup(ClassElement node, Settings settings) {
  final groupAnnotation =
      groupChecker.firstAnnotationOf(node, throwOnUnresolved: false);

  if (groupAnnotation != null) {
    return gen.Group.fromAnnotation(
      groupAnnotation,
      settings.getPriorityForGroup,
    );
  }

  return settings.getGroupForClass(node.name);
}

RegisterType? _getRegisterType(ClassElement node, Settings settings) {
  final registerAsAnnotation =
      registerAsChecker.firstAnnotationOf(node, throwOnUnresolved: false);

  if (registerAsAnnotation != null) {
    final registerAs = gen.RegisterAs.fromAnnotation(registerAsAnnotation);

    return registerAs;
  }

  return settings.getRegisterTypeForClass(node.name)?.annotationValue;
}

ConstructorElement _getConstructor(ClassElement node) {
  final constructors = node.constructors.where((e) {
    if (ignoreChecker.hasAnnotationOf(e, throwOnUnresolved: false)) {
      return false;
    }

    if (e.isPrivate) {
      return false;
    }

    return true;
  }).toList();

  if (constructors.isEmpty) {
    throw Exception('No constructors found for ${node.name}');
  }

  if (constructors.length == 1) {
    return constructors.first;
  }

  ConstructorElement? constructor;

  for (final ctor in constructors) {
    if (ctor.isDefaultConstructor) {
      constructor ??= ctor;
      continue;
    }

    if (useChecker.hasAnnotationOf(ctor, throwOnUnresolved: false)) {
      constructor = ctor;
      break;
    }
  }

  return constructor ?? node.constructors.first;
}
