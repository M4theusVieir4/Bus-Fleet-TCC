import 'dart:async';

import 'package:busbr/infra/config/dependency_manager/dependency_manager_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModularDependencyManager implements IDependencyManager {
  ModularDependencyManager._();

  static ModularDependencyManager? _instance;

  static ModularDependencyManager i() {
    _instance ??= ModularDependencyManager._();

    return _instance!;
  }

  @override
  T get<T extends Object>() {
    return Modular.get<T>();
  }

  @override
  bool dispose<T extends Object>() {
    return Modular.dispose<T>();
  }

  @override
  FutureOr<T> getAsync<T extends Object>() {
    return Modular.get<T>();
  }
}
