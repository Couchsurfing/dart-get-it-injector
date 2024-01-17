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
