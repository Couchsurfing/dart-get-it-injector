/**
Copyright 2024 CouchSurfing International Inc.

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
import 'dart:async' show FutureOr;

import 'package:build/build.dart';
import 'package:get_it_injector_gen/models/settings.dart';

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
