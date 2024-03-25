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
import 'package:get_it_injector_gen/builders.dart';

import 'package:generator_test/generator_test.dart';
import 'package:get_it_injector_gen/models/settings.dart';
import 'package:test/scaffolding.dart';

class GeneratorInput {
  GeneratorInput({
    required this.input,
    required this.output,
    required this.testDir,
    Settings? options,
  }) : options = options ?? Settings.defaults();

  final String testDir;
  final List<String> input;
  final List<String> output;
  final Settings options;

  String get fixturesDir => 'test/fixtures/$testDir';
  String get inputsDir => 'test/inputs/$testDir';
}

void main() {
  group('Breakdown Generator', () {
    final inputs = [
      GeneratorInput(
        input: [
          'repo_impl.dart',
          'repo.dart',
        ],
        output: [
          'repo_impl.get_it_injector.json',
          'repo.get_it_injector.json',
        ],
        testDir: 'test_1',
        options: Settings.defaults(
          registerAsImplementation: true,
          autoRegister: true,
        ),
      ),
      GeneratorInput(
        input: [
          'class_with_extends.dart',
        ],
        output: [
          'class_with_extends.get_it_injector.json',
        ],
        testDir: 'test_3',
        options: Settings.defaults(
          registerAsImplementation: true,
        ),
      ),
      GeneratorInput(
        input: [
          'repo_impl.dart',
          'repo.dart',
        ],
        output: [
          'repo_impl.get_it_injector.json',
          'repo.get_it_injector.json',
        ],
        testDir: 'test_5',
        options: Settings.defaults(
          registerAsImplementation: true,
          autoRegister: true,
          ignoreForFile: ['lint_1', 'lint_2'],
        ),
      ),
    ];

    for (final input in inputs) {
      test('runs', () async {
        final tester = SuccessGenerator.fromBuilder(
          input.input,
          input.output,
          breakdownGenerator,
          onLog: print,
          logLevel: Level.ALL,
          options: input.options.toJson(),
          fixtureDir: input.fixturesDir,
          inputDir: input.inputsDir,
        );

        await tester.test();
      });
    }
  });

  group('Config Generator', () {
    final inputs = [
      GeneratorInput(
        input: [
          'setup.dart',
          'repo_impl.get_it_injector.json',
          'repo.get_it_injector.json',
        ],
        output: [
          'setup.config.dart',
        ],
        testDir: 'test_2',
      ),
      GeneratorInput(
        input: [
          'ignore_for_file.dart',
          'repo.get_it_injector.json',
        ],
        output: [
          'ignore_for_file.config.dart',
        ],
        testDir: 'test_4',
      )
    ];

    for (final input in inputs) {
      test('runs', () async {
        final tester = SuccessGenerator.fromBuilder(
          input.input,
          input.output,
          getItInjectorGenerator,
          onLog: print,
          logLevel: Level.ALL,
          options: input.options.toJson(),
          fixtureDir: input.fixturesDir,
          inputDir: input.inputsDir,
        );

        await tester.test();
      });
    }
  });
}
