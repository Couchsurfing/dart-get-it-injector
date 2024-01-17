import 'package:get_it/get_it.dart';
import 'package:get_it_injector/get_it_injector.dart';

import 'FILE_NAME.config.dart'; // replace FILE_NAME with the name of _this_ file

final getIt = GetIt.instance;

@setup
Future<void> setup() {
  getIt.init();
}
