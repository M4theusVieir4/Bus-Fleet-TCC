import 'package:busbr/infra/config/network/response/failure.dart';
import 'package:busbr/infra/config/network/response/result.dart';
import 'package:busbr/infra/config/network/response/base_response.dart';

import 'package:dio/dio.dart';

extension FutureExtension on Future<dynamic> {
  AsyncResult<R> result<R>(
    R Function(Map<String, dynamic> json) onValue,
  ) async {
    try {
      final response = (await this).data;

      final isValid = response['is_valid'] ?? true;

      if (isValid) {
        return SuccessfulState(onValue(response));
      }

      final error = BaseResponse.fromJson(response);
      return ErrorState(DataFailure(error));
    } on DioException catch (e) {
      return ErrorState(HttpFailure(e));
    } on TypeError catch (e) {
      return ErrorState(UnknownFailure(e));
    }
  }

  AsyncResult<R> resultList<R>(
    R Function(List<dynamic> list) onValue,
  ) async {
    try {
      final response = await this;

      return SuccessfulState(onValue(response.data));
    } on DioException catch (e) {
      return ErrorState(HttpFailure(e));
    } on TypeError catch (e) {
      return ErrorState(UnknownFailure(e));
    }
  }
}
