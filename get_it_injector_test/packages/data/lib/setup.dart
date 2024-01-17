import 'package:get_it/get_it.dart';
import 'package:get_it_injector/get_it_injector.dart' as get_it_injector;
import 'package:_data/setup.config.dart';

@get_it_injector.setup
void setup(GetIt getIt) {
  getIt.init();
}
