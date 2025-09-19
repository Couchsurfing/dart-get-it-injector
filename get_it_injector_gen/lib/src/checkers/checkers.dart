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
import 'package:get_it_injector/get_it_injector.dart';
import 'package:source_gen/source_gen.dart';

const setupChecker =
    TypeChecker.typeNamed(Setup, inPackage: 'get_it_injector', inSdk: false);

const ignoreChecker =
    TypeChecker.typeNamed(Ignore, inPackage: 'get_it_injector', inSdk: false);

const useChecker =
    TypeChecker.typeNamed(Use, inPackage: 'get_it_injector', inSdk: false);

const priorityChecker =
    TypeChecker.typeNamed(Priority, inPackage: 'get_it_injector', inSdk: false);

const groupChecker =
    TypeChecker.typeNamed(Group, inPackage: 'get_it_injector', inSdk: false);

const registerAsChecker = TypeChecker.typeNamed(RegisterAs,
    inPackage: 'get_it_injector', inSdk: false);
