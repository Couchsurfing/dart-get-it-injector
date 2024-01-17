import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:get_it_injector/get_it_injector.dart';
import 'package:get_it_injector_core/get_it_injector_core.dart';
import 'package:get_it_injector_gen/src/writers/write_config.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

class GetItInjectorGenerator extends GeneratorForAnnotation<Setup> {
  GetItInjectorGenerator(this.settings);

  final Settings settings;

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! FunctionElement) {
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
    injectables.sort((a, b) => b.priority.compareTo(a.priority));

    final emitter = DartEmitter(useNullSafetySyntax: true);

    final generated = writeConfig(injectables);

    final output = generated.map((e) => e.accept(emitter)).join('\n');

    return DartFormatter().format(output);
  }
}
