import 'package:get_it_injector/get_it_injector.dart';

/// {@macro setup}
const setup = Setup();

/// {@macro use}
const use = Use();

/// {@macro ignore}
const ignore = Ignore();

/// {@macro priority}
///
/// This is the default priority.
///
/// value = 0
const lowPriority = Priority(0);

/// {@macro priority}
///
/// This will be injected after [lowPriority].
///
/// value = 50
const mediumPriority = Priority(50);

/// {@macro priority}
///
/// This will be injected after [mediumPriority].
///
/// value = 100
const highPriority = Priority(100);

/// {@macro singleton}
const singleton = RegisterAs(RegisterType.singleton);

/// {@macro singleton}
const lazySingleton = RegisterAs(RegisterType.lazySingleton);

/// {@macro factory}
const factory = RegisterAs(RegisterType.factory);
