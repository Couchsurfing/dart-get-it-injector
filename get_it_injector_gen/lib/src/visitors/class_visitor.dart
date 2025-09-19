// --- LICENSE ---
/**
Copyright 2025 CouchSurfing International Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
// --- LICENSE ---
// ignore_for_file: deprecated_member_use


import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/visitor2.dart';
import 'package:get_it_injector/get_it_injector.dart' hide Group;
import 'package:get_it_injector_gen/models/group.dart';
import 'package:get_it_injector_gen/models/settings.dart';
import 'package:get_it_injector_gen/src/checkers/checkers.dart';
import 'package:get_it_injector_gen/src/models/models.dart' as gen;

class ClassVisitor extends RecursiveElementVisitor2<void> {
  ClassVisitor(this.settings);

  final Settings settings;

  final List<gen.InjectableElement> nodes = [];

  @override
  void visitClassElement(ClassElement2 node) {
    if (ignoreChecker.hasAnnotationOf(node, throwOnUnresolved: false)) {
      return;
    }

    if (node.isPrivate) {
      return;
    }

    if (node.isAbstract) {
      return;
    }

    final ConstructorElement2 constructor = _getConstructor(node);
    final Iterable<ClassElement2> implementations = _getImplementation(
      node,
      settings,
    );
    final Priority? priority = _getPriority(node, settings);
    final Group? group = _getGroup(node, settings);
    final RegisterType? registerType = _getRegisterType(node, settings);

    if (registerType == null && group == null && priority == null) {
      // Not registered as anything, skip
      return;
    }

    final element = gen.InjectableElement(
      element: node,
      implementations: implementations.toList(),
      constructor: constructor,
      priority: priority ?? settings.defaultPriority,
      group: group,
      registerType: registerType ?? settings.registerDefault.annotationValue,
      ignoreForFile: settings.ignoreForFile,
    );

    nodes.add(element);
  }
}

Iterable<ClassElement2> _getImplementation(
  ClassElement2 node,
  Settings settings,
) sync* {
  if (!settings.registerAsImplementation) {
    return;
  }

  // get declaration string
  final signature = '$node';

  // check source if implementation keyword is used
  if (!signature.contains('implements')) {
    return;
  }

  // get class name of implementation from source
  final classNames = signature
      .substring(signature.indexOf('implements') + 'implements'.length)
      .replaceAll(',', '')
      .split(' ')
      .where((e) => e.isNotEmpty);

  for (final interface in node.interfaces) {
    if (interface.element3 is! ClassElement2) {
      continue;
    }

    if (!classNames.contains(interface.element3.name3)) {
      continue;
    }

    yield interface.element3 as ClassElement2;
  }
}

Priority? _getPriority(ClassElement2 node, Settings settings) {
  final priorityAnnotation = priorityChecker.firstAnnotationOf(
    node,
    throwOnUnresolved: false,
  );

  if (priorityAnnotation != null) {
    return gen.Priority.fromAnnotation(priorityAnnotation);
  }

  if (node.name3 case final String name) {
    return settings.getPriorityForClass(name);
  }

  return null;
}

Group? _getGroup(ClassElement2 node, Settings settings) {
  final groupAnnotation = groupChecker.firstAnnotationOf(
    node,
    throwOnUnresolved: false,
  );

  if (groupAnnotation != null) {
    return gen.Group.fromAnnotation(
      groupAnnotation,
      settings.getPriorityForGroup,
    );
  }

  if (node.name3 case final String name) {
    return settings.getGroupForClass(name);
  }

  return null;
}

RegisterType? _getRegisterType(ClassElement2 node, Settings settings) {
  final registerAsAnnotation = registerAsChecker.firstAnnotationOf(
    node,
    throwOnUnresolved: false,
  );

  if (registerAsAnnotation != null) {
    final registerAs = gen.RegisterAs.fromAnnotation(registerAsAnnotation);

    return registerAs;
  }

  if (node.name3 case final String name) {
    return settings.getRegisterTypeForClass(name)?.annotationValue;
  }

  return null;
}

ConstructorElement2 _getConstructor(ClassElement2 node) {
  final constructors = node.constructors2.where((e) {
    if (ignoreChecker.hasAnnotationOf(e, throwOnUnresolved: false)) {
      return false;
    }

    if (e.isPrivate) {
      return false;
    }

    return true;
  }).toList();

  if (constructors.isEmpty) {
    throw Exception('No constructors found for ${node.name3}');
  }

  if (constructors.length == 1) {
    return constructors.first;
  }

  ConstructorElement2? constructor;

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

  return constructor ?? node.constructors2.first;
}
