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
import 'package:get_it/get_it.dart';
import 'package:get_it_injector/get_it_injector.dart' as get_it_injector;
import 'package:_data/setup.config.dart';

@get_it_injector.setup
void setup(GetIt getIt) {
  getIt.init();
}
