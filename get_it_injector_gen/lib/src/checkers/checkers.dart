import 'package:get_it_injector/get_it_injector.dart';
import 'package:source_gen/source_gen.dart';

const setupChecker = TypeChecker.fromRuntime(Setup);
const ignoreChecker = TypeChecker.fromRuntime(Ignore);
const useChecker = TypeChecker.fromRuntime(Use);
const priorityChecker = TypeChecker.fromRuntime(Priority);
const groupChecker = TypeChecker.fromRuntime(Group);
const registerAsChecker = TypeChecker.fromRuntime(RegisterAs);
