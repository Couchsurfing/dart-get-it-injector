[![Pub Package](https://img.shields.io/pub/v/get_it_injector.svg)](https://pub.dev/packages/get_it_injector)

# `get_it_injector`

`get_it_injector` is an annotation package designed to simplify and enhance the registration of classes for dependency injection using the `get_it` package in Dart. It provides annotations that facilitate the generation of code to register factories, singletons, and lazy singletons, allowing for streamlined dependency management.

## Features

-   **Flexible Registration:** Annotate your classes to easily configure whether they should be registered as factories, singletons, or lazy singletons, giving you control over how instances are managed by `get_it`.

-   **Order of Injection:** Define class name patterns to determine the order of injection, providing a priority system for injecting classes in a specific sequence.

-   **Grouping:** Organize injectables into groups, each with its own priority, to further customize the injection order and manage dependencies more effectively.

Read more about how to use `get_it_injector` in [`get_it_injector_gen`](https://pub.dev/packages/get_it_injector_gen).

## License
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
This software is released under the Apache 2.0 license. https://www.apache.org/licenses/LICENSE-2.0