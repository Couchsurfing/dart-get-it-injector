import 'dart:async' show FutureOr;

import 'package:build/build.dart';
import 'package:get_it_injector_core/get_it_injector_core.dart';
import 'package:get_it_injector_gen/src/visitors/class_visitor.dart';
import 'package:source_gen/source_gen.dart' hide TypeChecker;

final class GetItInjectorBreakdownGenerator extends Generator {
  GetItInjectorBreakdownGenerator(this.settings);

  final Settings settings;

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final visitor = ClassVisitor(settings);
    library.element.visitChildren(visitor);

    if (visitor.nodes.isEmpty) {
      return null;
    }

    final output = visitor.nodes.map((e) => e.toJson()).join(',');

    return '[$output]';
  }
}
