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
import 'package:analyzer/dart/constant/value.dart';
import 'package:get_it_injector/get_it_injector.dart';

class RegisterAs {
  static RegisterType? fromAnnotation(DartObject object) {
    final typeIndex = object.getField('type')?.getField('index')?.toIntValue();

    if (typeIndex == null) {
      return null;
    }

    final type = RegisterType.values[typeIndex];

    return type;
  }
}
