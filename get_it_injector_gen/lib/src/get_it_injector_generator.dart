// ignore_for_file: deprecated_member_use

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
import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:get_it_injector/get_it_injector.dart';
import 'package:get_it_injector_gen/models/injectable.dart';
import 'package:get_it_injector_gen/models/settings.dart';
import 'package:get_it_injector_gen/src/writers/write_config.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

class GetItInjectorGenerator extends GeneratorForAnnotation<Setup> {
  GetItInjectorGenerator(this.settings);

  final Settings settings;

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! TopLevelFunctionElement) {
      throw InvalidGenerationSourceError(
        'Setup annotation can only be used on functions.',
        element: element,
      );
    }

    final pattern = Glob('**/*.get_it_injector.json');
    final futures = <Future<String>>[];
    await for (final id in buildStep.findAssets(pattern)) {
      futures.add(buildStep.readAsString(id));
    }

    final content = await Future.wait(futures);

    final raw = content.map((e) => (jsonDecode(e) as List)).expand((e) => e);

    final injectables = raw.map((e) => Injectable.fromJson(e)).toList();

    // the higher the priority, the earlier it is registered
    injectables
      ..sort((a, b) => a.type.compareTo(b.type))
      ..sort((a, b) => b.priority.compareTo(a.priority));

    final emitter = DartEmitter(useNullSafetySyntax: true);

    final generated = writeConfig(injectables);

    final output = generated.map((e) => e.accept(emitter)).join('\n');

    return DartFormatter(
      languageVersion: DartFormatter.latestLanguageVersion,
    ).format(output);
  }
}
