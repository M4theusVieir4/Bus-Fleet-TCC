import 'package:busbr/infra/config/network/response/failure.dart';
import 'package:flutter/foundation.dart';

typedef Success<R, T> = R Function(T data);
typedef Error<R> = R Function(Failure error);
typedef AsyncResult<T> = Future<Result<T>>;

sealed class Result<T> {
  T get data => (this as SuccessfulState).value;
  Failure get error => (this as ErrorState).e;

  R result<R>(Success<R, T> success, Error<R> error) {
    return switch (this) {
      SuccessfulState(value: final value) => success(value),
      ErrorState(error: final failure) => error(failure),
    };
  }
}

class SuccessfulState<T> extends Result<T> {
  final T value;
  SuccessfulState(this.value);
}

class ErrorState<T> extends Result<T> {
  final Failure e;
  ErrorState(this.e);
}
