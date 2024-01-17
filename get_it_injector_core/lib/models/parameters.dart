import 'package:get_it_injector_core/enums/parameter_type.dart';
import 'package:get_it_injector_core/models/parameter.dart';

abstract mixin class Parameters {
  List<Parameter> get parameters;

  List<Parameter> get positionalParameters =>
      parameters.where((e) => e.location == ParameterType.positional).toList();

  List<Parameter> get namedParameters =>
      parameters.where((e) => e.location == ParameterType.named).toList();

  List<String> get parameterImports => parameters
      .map(_parameterImports)
      .expand((e) => e)
      .whereType<String>()
      .toList();

  Iterable<String?> _parameterImports(Parameter param) sync* {
    yield param.import;

    for (final p in param.parameters) {
      yield* _parameterImports(p);
    }
  }
}
