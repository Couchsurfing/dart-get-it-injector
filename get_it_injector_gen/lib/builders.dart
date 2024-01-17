import 'package:get_it_injector_gen/src/get_it_injector_breakdown_generator.dart';
import 'package:get_it_injector_gen/src/get_it_injector_generator.dart';
import 'package:get_it_injector_core/get_it_injector_core.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// The entry point for the get_it_injector generator.
Builder breakdownGenerator(BuilderOptions options) {
  final settings = Settings.fromJson(options.config);

  return LibraryBuilder(
    GetItInjectorBreakdownGenerator(settings),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.get_it_injector.json',
  );
}

Builder getItInjectorGenerator(BuilderOptions options) {
  final settings = Settings.fromJson(options.config);

  return LibraryBuilder(
    GetItInjectorGenerator(settings),
    generatedExtension: '.config.dart',
  );
}
