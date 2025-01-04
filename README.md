[![Pub Package](https://img.shields.io/pub/v/get_it_injector_gen.svg)](https://pub.dev/packages/get_it_injector_gen)

# `get_it_injector_gen`

`get_it_injector_gen` is a code generator package that complements `get_it_injector` by automating the generation of code for registering classes with the `get_it` package in Dart. This generator simplifies the process of dependency injection by generating the necessary code based on annotations from `get_it_injector`.

## Why `get_it_injector_gen`?

For real-world projects, managing dependencies manually can become cumbersome. The goal of `get_it_injector_gen` is to automate the registration process, making it easy to configure and manage dependencies using the `get_it` package.

### Features

- **Flexible Registration:** Annotate your classes with `get_it_injector` annotations to define whether they should be registered as factories, singletons, or lazy singletons. The generator will handle the code generation for you.

- **Order of Injection:** Define class name patterns to determine the order of injection, allowing you to control the sequence in which classes are injected.

- **Grouping:** Organize injectables into groups with their own **priorities**, providing a more fine-grained approach to dependency management.

- **Register As Implementation:** Register the implementation class as the type argument when registering the injectable. (Also supports registering classes that implement multiple interfaces!)

## Getting Started

1. Add the `get_it_injector` and `get_it_injector_gen` packages to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     get_it_injector: # latest version

   dev_dependencies:
     get_it_injector_gen: # latest version
     build_runner: # latest version
   ```

2. Configure the build runner to use `get_it_injector_gen` in your `build.yaml` file:

   ```yaml
   targets:
     $default:
       builders:
         get_it_injector_gen:
           generate_for:
             - lib/**/*.dart
           options:
             # Add your options here
   ```

   _All option's casing are formatted in **snake_case**_

   Check out the [settings] to learn more about the available options.

3. Feed your classes to the generator

### By Annotation

      ```dart
      import 'package:get_it_injector/get_it_injector.dart';

      @singleton
      class MySingletonService {
          // Implementation details...
      }
      ```

### By Configuration

You can include all classes using the `auto_register` option.

You can use `groups`, `register`, `factories`, `singletons`, `lazy_singletons` and `priorities` to filter the classes that should be registered. Each accept a list of regex patterns that will be used to match the class names.

```yaml
targets:
  $default:
    builders:
      get_it_injector_gen:
        generate_for:
          - lib/**/*.dart
        options:
          auto_register: true
          groups:
            - PATTERN # regex
          register:
            - PATTERN # regex
          factories:
            - PATTERN # regex
          singletons:
            - PATTERN # regex
          lazy_singletons:
            - PATTERN # regex
          priorities:
            - PATTERN # regex
```

      _For more details on each input, refer to the Settings Interface file_

1. Add the setup function

   ```dart
   import 'package:get_it/get_it.dart';
   import 'package:get_it_injector/get_it_injector.dart';

   import 'FILE_NAME.config.dart'; // replace FILE_NAME with the name of _this_ file

   final getIt = GetIt.instance;

   @setup
   Future<void> setup() {
      getIt.init();
   }
   ```

2. Run the build command to generate the registration code:

   ```bash
   # using flutter
   flutter pub run build_runner build --delete-conflicting-outputs

   # using dart
   pub run build_runner build --delete-conflicting-outputs
   ```

## Settings

The `build.yaml` file provides several settings to configure the behavior of the `get_it_injector_gen` package. Below is an overview of the available settings:

- **register_as_implementation**: A boolean value indicating whether to use the implementation class as the type argument when registering the injectable.

- **priorities**: A list of class name regex patterns (case sensitive) to determine the order of injection. The first pattern in the list will be injected first, and the last pattern will be injected last. The priority value decrements by 10 for each pattern, starting at 50.

- **singletons**: A list of class name regex patterns (case sensitive) to determine whether to register the injectable as a singleton.

- **lazy_singletons**: A list of class name regex patterns (case sensitive) to determine whether to register the injectable as a lazy singleton.

- **factories**: A list of class name regex patterns (case sensitive) to determine whether to register the injectable as a factory.

- **register_default**: The default register type to use when registering an injectable. This can be set to `singleton`, `lazySingleton`, or `factory`.

- **auto_register**: A boolean value indicating whether to automatically register all classes. If set to true, the `register_default` will be used to determine the register type.

- **register**: A list of class name regex patterns (case sensitive) to determine whether to register the injectable. This setting is ignored if `auto_register` is true.

- **do_not_register**: A list of class name regex patterns (case sensitive) to determine whether to ignore the injectable. This is intended to be used in conjunction with `auto_register`.

- **groups**: A map of group names used to group injectables. Each group contains a list of class name regex patterns (case sensitive). The priority value for each group is decremented by 10 for each group, starting at 50.

- **ignore_for_file**: A list of lint rules to ignore for the generated file.

These settings allow you to customize the behavior of the code generator to fit your project's needs. For more details on each setting, refer to the `SettingsInterface` file.

### Register As Implementation

This setting allows you to register the implementation class as the implementation clause when registering the injectable. This can be useful when you want to register an interface with a specific implementation.

```yaml
targets:
  $default:
    builders:
      get_it_injector_gen:
        generate_for:
          - lib/**/*.dart
        options:
          register_as_implementation: true
```

```dart
class MyServiceImpl implements MyService {}
```

```dart
# Generated code (summary)

getIt.registerSingleton<MyService>(MyServiceImpl());
```

#### Multiple Interfaces

If a class implements multiple interfaces, the generator will register the class as the implementation for each interface.

```dart
class ServiceImpl implements ReadOnlyService, WriteOnlyService {}
```

```dart
# Generated code (summary)

getIt.registerSingleton(ServiceImpl());
getIt.registerSingleton<ReadOnlyService>(getIt<ServiceImpl>());
getIt.registerSingleton<WriteOnlyService>(getIt<ServiceImpl>());
```

## Issues and Contributions

If you encounter any issues or have suggestions for improvements, please feel free to open an issue or contribute to the project on [GitHub](https://github.com/your-username/get_it_injector_gen).

## A note about `build_runner`

The build runner performance can be optimized by flattening your project structure, especially if you have nested folders. Consider using the `exclude` option in `build.yaml` to exclude unnecessary folders from the scanning process.

```yaml
targets:
  $default:
    builders:
      get_it_injector_gen:
        generate_for:
          include:
            - lib/**/*.dart
          exclude:
            - lib/ui/**
```

_`generate_for.include` & `generate_for.exclude` are part of the `build.yaml` format. You can find more information [here](https://github.com/dart-lang/build/blob/master/docs/build_yaml_format.md)_

## License

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
This software is released under the Apache 2.0 license. <https://www.apache.org/licenses/LICENSE-2.0>

[settings]: #settings
