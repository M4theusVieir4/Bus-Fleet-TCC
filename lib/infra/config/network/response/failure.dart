import 'package:busbr/infra/config/network/response/base_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class Failure {
  String get code;

  String get message;

  dynamic get response;

  StackTrace? get stackTrace;
}

class DataFailure extends Failure {
  final BaseResponse error;

  DataFailure(this.error);

  @override
  String get code => error.message;

  @override
  String get message => error.message;

  @override
  get response => error.isValid;

  @override
  get stackTrace => StackTrace.empty;
}

class HttpFailure implements Failure {
  final DioException error;

  HttpFailure(this.error);

  @override
  String get code => error.response?.statusCode.toString() ?? '';

  @override
  String get message => error.message ?? '';

  @override
  get response => error.message;

  @override
  StackTrace get stackTrace => error.stackTrace;
}

class UnknownFailure implements Failure {
  final TypeError error;

  UnknownFailure(this.error);

  @override
  String get code => error.hashCode.toString();

  @override
  String get message => kDebugMode ? error.toString() : '';

  @override
  get response => error;

  @override
  StackTrace? get stackTrace => error.stackTrace;
}
