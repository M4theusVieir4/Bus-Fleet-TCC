import 'dart:async';

abstract class IDependencyManager {
  T get<T extends Object>();

  FutureOr<T> getAsync<T extends Object>() {
    throw UnimplementedError();
  }

  bool dispose<T extends Object>();
}
