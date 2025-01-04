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
import 'package:get_it_injector_gen/enums/register_type.dart';

abstract interface class SettingsInterface {
  /// Whether to use the implementation class as the
  /// type arg when registering the injectable
  bool get registerAsImplementation;

  /// A list of class name regex patterns (case sensitive) to use to determine
  /// the order of injection.
  ///
  /// The first pattern in the list will be injected first, while
  /// the last pattern in the list will be injected last.
  ///
  /// The priority value decrements by 10 for each pattern,
  /// starting at 50.
  ///
  /// e.g.
  /// ```yaml
  /// priorities:
  ///    - ^A # Priority = 50
  ///    - ^B # Priority = 40
  ///    - ^C # Priority = 30
  /// ```
  List<String> get priorities;

  /// A list of class name regex patterns (case sensitive) to use to determine
  /// whether to register the injectable as a singleton.
  List<String> get singletons;

  /// A list of class name regex patterns (case sensitive) to use to determine
  /// whether to register the injectable as a lazy singleton.
  List<String> get lazySingletons;

  /// A list of class name regex patterns (case sensitive) to use to determine
  /// whether to register the injectable as a factory.
  List<String> get factories;

  /// The default register type to use when registering an injectable.
  RegisterType get registerDefault;

  /// Whether to automatically register all classes.
  ///
  /// The [registerDefault] will be used to determine the register type.
  bool get autoRegister;

  /// A list of class name regex patterns (case sensitive) to use to determine
  /// whether to register the injectable.
  ///
  /// [priorities], [singletons], [lazySingletons], [factories], and [groups] will take priority before [register].
  ///
  /// if [autoRegister] is true, then [register] will be ignored.
  ///
  /// As opposed to [priorities], [register] has no effect on the order of injection.
  List<String> get register;

  /// A list of class name regex patterns (case sensitive) to use to determine
  /// whether to ignore the injectable.
  ///
  /// This is intended to be used in conjunction with [autoRegister].\
  /// It will do \*\*nothing\*\* if [autoRegister] is false.
  List<String> get doNotRegister;

  /// A list of group names used to group injectables.
  /// The values of each group are the class name regex patterns (case sensitive)
  ///
  /// The priority value for each group is decremented by 10 for each group,
  /// starting at 50.
  ///
  /// e.g.
  /// ```yaml
  /// groups:
  ///  group1: # Priority = 50
  ///   - ^A
  ///   - ^B
  ///  group2: # Priority = 40
  ///   - ^C
  ///   - ^D
  Map<String, List<String>> get groups;

  /// A list of lint rules to ignore for the generated file.
  List<String> get ignoreForFile;
}
