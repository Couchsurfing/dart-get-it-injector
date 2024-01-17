import 'package:get_it_injector/get_it_injector.dart'
    show Priority, lowPriority;
import 'package:get_it_injector_core/enums/register_type.dart';
import 'package:get_it_injector_core/models/group.dart';
import 'package:get_it_injector_core/models/settings_interface.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@JsonSerializable(constructor: 'defaults')
class Settings implements SettingsInterface {
  const Settings({
    required this.registerAsImplementation,
    required this.priorities,
    required this.groups,
    required this.factories,
    required this.lazySingletons,
    required this.singletons,
    required this.registerDefault,
    required this.autoRegister,
    required this.register,
    required this.doNotRegister,
    required this.ignoreForFile,
  });

  Settings.defaults({
    this.registerAsImplementation = false,
    this.priorities = const [],
    this.groups = const {},
    this.factories = const [],
    this.lazySingletons = const [],
    this.singletons = const [],
    this.registerDefault = RegisterType.factory,
    this.autoRegister = false,
    this.register = const [],
    this.doNotRegister = const [],
    List<String>? ignoreForFile,
  }) : ignoreForFile = ignoreForFile ?? [];

  factory Settings.fromJson(Map json) {
    final result = _$SettingsFromJson(json);

    final patterns = <String, List<String>>{};

    result.priorities
        .forEach((e) => patterns.putIfAbsent(e, () => []).add('priorities'));
    result.register
        .forEach((e) => patterns.putIfAbsent(e, () => []).add('register'));
    result.factories
        .forEach((e) => patterns.putIfAbsent(e, () => []).add('factories'));
    result.lazySingletons.forEach(
        (e) => patterns.putIfAbsent(e, () => []).add('lazy_singletons'));
    result.singletons
        .forEach((e) => patterns.putIfAbsent(e, () => []).add('singletons'));
    result.doNotRegister.forEach(
        (e) => patterns.putIfAbsent(e, () => []).add('do_not_register'));

    // make sure that the priorities patterns are valid regex
    for (final MapEntry(key: pattern, value: locations) in patterns.entries) {
      try {
        RegExp(pattern);
      } catch (error) {
        throw ArgumentError.value(
          pattern,
          'Found in ${locations.join(',')}',
          error,
        );
      }
    }

    return result;
  }

  @override
  final bool autoRegister;

  @override
  final List<String> factories;

  @override
  final Map<String, List<String>> groups;

  @override
  final List<String> lazySingletons;

  @override
  final List<String> priorities;

  @override
  final List<String> register;

  @override
  final List<String> doNotRegister;

  @override
  final bool registerAsImplementation;

  @override
  final RegisterType registerDefault;

  @override
  final List<String> singletons;

  @override
  @JsonKey(defaultValue: [])
  final List<String> ignoreForFile;

  Priority get defaultPriority => lowPriority;

  int? getPriorityForGroup(String group) {
    var priority = 50;

    final keys = groups.keys.toList();

    final index = keys.indexOf(group);

    if (index == -1) {
      return null;
    }

    return priority - (index * 10);
  }

  Priority? getPriorityForClass(String className) {
    var priority = 50 + 10;
    for (final pattern in priorities) {
      priority -= 10;

      if (RegExp(pattern).hasMatch(className)) {
        return Priority(priority);
      }
    }

    return null;
  }

  Group? getGroupForClass(String className) {
    for (final group in groups.entries) {
      for (final pattern in group.value) {
        if (RegExp(pattern).hasMatch(className)) {
          return Group(
            name: group.key,
            priority: getPriorityForGroup(group.key)!,
          );
        }
      }
    }

    return null;
  }

  RegisterType? getRegisterTypeForClass(String name) {
    if (singletons.any((pattern) => RegExp(pattern).hasMatch(name))) {
      return RegisterType.singleton;
    }

    if (lazySingletons.any((pattern) => RegExp(pattern).hasMatch(name))) {
      return RegisterType.lazySingleton;
    }

    if (factories.any((pattern) => RegExp(pattern).hasMatch(name))) {
      return RegisterType.factory;
    }

    if (autoRegister) {
      for (final pattern in doNotRegister) {
        if (RegExp(pattern).hasMatch(name)) {
          return null;
        }
      }

      return registerDefault;
    }

    if (register.any((pattern) => RegExp(pattern).hasMatch(name))) {
      return registerDefault;
    }

    return null;
  }

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
