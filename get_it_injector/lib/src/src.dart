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
