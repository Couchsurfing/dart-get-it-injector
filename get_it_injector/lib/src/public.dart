// --- LICENSE ---
/**
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
*/
// --- LICENSE ---
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
