import 'package:generator_test/generator_test.dart';
import 'package:get_it_injector_gen/builders.dart';
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
        input: ['repo_impl.dart', 'repo.dart'],
        output: ['repo_impl.get_it_injector.json', 'repo.get_it_injector.json'],
        testDir: 'test_1',
        options: Settings.defaults(
          registerAsImplementation: true,
          autoRegister: true,
        ),
      ),
      GeneratorInput(
        input: ['class_with_extends.dart'],
        output: ['class_with_extends.get_it_injector.json'],
        testDir: 'test_3',
        options: Settings.defaults(registerAsImplementation: true),
      ),
      GeneratorInput(
        input: ['repo_impl.dart', 'repo.dart'],
        output: ['repo_impl.get_it_injector.json', 'repo.get_it_injector.json'],
        testDir: 'test_5',
        options: Settings.defaults(
          registerAsImplementation: true,
          autoRegister: true,
          ignoreForFile: ['lint_1', 'lint_2'],
        ),
      ),
      GeneratorInput(
        input: ['multi.dart', 'one.dart', 'two.dart'],
        output: [
          'multi.get_it_injector.json',
          'one.get_it_injector.json',
          'two.get_it_injector.json',
        ],
        testDir: 'test_6',
        options: Settings.defaults(
          registerAsImplementation: true,
          autoRegister: true,
        ),
      ),
      GeneratorInput(
        input: ['repo.dart', 'repo_factory.dart'],
        output: ['repo.get_it_injector.json'],
        options: Settings.defaults(autoRegister: true),
        testDir: 'typedef',
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
      }, skip: 'TODO: fix');
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
        output: ['setup.config.dart'],
        testDir: 'test_2',
      ),
      GeneratorInput(
        input: ['ignore_for_file.dart', 'repo.get_it_injector.json'],
        output: ['ignore_for_file.config.dart'],
        testDir: 'test_4',
      ),
      GeneratorInput(
        input: ['multi.get_it_injector.json', 'setup.dart'],
        output: ['setup.config.dart'],
        testDir: 'test_7',
      ),
      GeneratorInput(
        input: ['multi.get_it_injector.json', 'setup.dart'],
        output: ['setup.config.dart'],
        testDir: 'test_8',
      ),
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
      }, skip: 'TODO: fix');
    }
  });
}
