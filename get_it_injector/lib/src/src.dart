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
import 'package:meta/meta_meta.dart';

/// {@template setup}
/// The annotated function is used to setup the dependency injection.
/// {@endtemplate}
@Target({TargetKind.function})
class Setup {
  /// {@macro setup}
  const Setup();
}

/// {@template use}
/// Use the annotated constructor instead of the default/first constructor.
/// {@endtemplate}
class Use {
  /// {@macro use}
  const Use();
}

/// {@template ignore}
/// Ignore the annotated element.
/// {@endtemplate}
class Ignore {
  /// {@macro ignore}
  const Ignore();
}

/// {@template priority}
/// The priority is used to determine the order of injection.
///
/// The higher the priority, the earlier the injection.
/// {@endtemplate}
class Priority {
  /// {@macro rank}
  const Priority(this.value);

  final int value;
}

/// {@template group}
/// The group to be used to group injectables.
/// {@endtemplate}
class Group {
  /// {@macro group}
  const Group(this.name);

  final String name;
}

enum RegisterType {
  factory,
  singleton,
  lazySingleton,
}

/// {@template register_as}
/// Register the annotated class as the given [type].
/// {@endtemplate}
class RegisterAs {
  /// {@macro register_as}
  const RegisterAs(this.type);

  final RegisterType type;
}
