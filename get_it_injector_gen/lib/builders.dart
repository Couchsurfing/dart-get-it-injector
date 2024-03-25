/**
--- LICENSE ---
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
--- LICENSE ---
*/
import 'package:get_it_injector_gen/models/settings.dart';
import 'package:get_it_injector_gen/src/get_it_injector_breakdown_generator.dart';
import 'package:get_it_injector_gen/src/get_it_injector_generator.dart';

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
