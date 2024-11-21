import 'dart:async';

import 'package:busbr/domain/interfaces/services/auth_service_interface.dart';
import 'package:busbr/infra/config/dependency_manager/dependency_manager.dart';
import 'package:busbr/infra/config/environment/environment_config.dart';
import 'package:busbr/infra/config/network/response/client/http_client_interface.dart';
import 'package:busbr/infra/core/constants/app_constants.dart';
import 'package:busbr/infra/core/extensions/http/http_extension.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpClient implements IHttpClient {
  final Dio _dio;

  //final FirebaseCrashlyticsService _crashlytics;

  int _refreshTokenAttempts = 0;

  HttpClient(
    this._dio,
    //this._crashlytics,
  ) {
    _dio.options = BaseOptions(
      baseUrl: EnvironmentConfig.baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(milliseconds: AppConstants.connectTimeout),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
    );

    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onError: _onError,
        //onRequest: _onRequest,
      ),
      PrettyDioLogger(requestBody: true, requestHeader: true),
    ]);
  }

  // Future<String> getAccessToken() {
  //   return Instance.get<IAuthService>().getAuthData().then(
  //         (auth) => auth?['token'] ?? '',
  //       );
  // }

  // Future<String> getRefreshToken() {
  //   return Instance.get<IAuthService>().getAuthData().then(
  //         (auth) => auth?['tokenAtualizacao'] ?? '',
  //       );
  // }

  // Future<void> _onRequest(
  //   RequestOptions options,
  //   RequestInterceptorHandler handler,
  // ) async {
  //   options.setAuthenticationHeader(await getAccessToken());
  //   handler.next(options);
  // }

  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = error.response?.statusCode;

    if ((statusCode != 403 && statusCode != 401) ||
        _refreshTokenAttempts >= AppConstants.refreshTokenAttemps) {
      return handler.next(error);
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      _refreshTokenAttempts = 0;
      // return await Instance.get<LogoutUseCase>().call();
    }

    try {
      _refreshTokenAttempts++;

      // var refreshToken = await getRefreshToken();
      // var authService = Instance.get<IAuthService>();

      // var loginResponseModel =
      //     await authService.loginByRefreshToken(refreshToken: refreshToken);

      // loginResponseModel.result(
      //     (data) async => await authService.setAuthData(auth: data),
      //     (error) => null);

      // error.requestOptions.setAuthenticationHeader(await getAccessToken());

      Options options = Options(
        method: error.requestOptions.method,
        headers: error.requestOptions.headers,
      );

      Response response = await _dio.request(
        error.requestOptions.path,
        options: options,
        data: error.requestOptions.data,
        queryParameters: error.requestOptions.queryParameters,
      );

      handler.resolve(response);
    } catch (_) {
      _refreshTokenAttempts = 0;
      // await Instance.get<LogoutUseCase>().call();
    }
    verify(error, handler);
    logErrorToCrashlytics(error, handler);
  }

  void logErrorToCrashlytics(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    final response = error.response;
    final requestOptions = response?.requestOptions;

    final statusCode = response?.statusCode.toString();
    final statusMessage = response?.statusMessage.toString();
    final queryParameters = requestOptions?.queryParameters.toString();
    final endpoint = requestOptions?.uri.toString();
    final responseData = response?.data.toString();

    // _crashlytics
    //   ..setCustomKey(event: 'status_code', value: statusCode)
    //   ..setCustomKey(event: 'message', value: statusMessage)
    //   ..setCustomKey(event: 'data', value: queryParameters)
    //   ..setCustomKey(event: 'endpoint', value: endpoint)
    //   ..setCustomKey(event: 'response', value: responseData)
    //   ..recordError(error);

    handler.next(error);
  }

  void verify(DioException originalError, ErrorInterceptorHandler handler) {
    final statusCode = originalError.response?.statusCode;

    String newErrorMessage = switch (statusCode) {
      401 => 'Sem autenticação',
      _ => 'Problemas na conexão com a API'
    };

    DioException newError = DioException(
      requestOptions: originalError.requestOptions,
      response: originalError.response,
      type: originalError.type,
      message: newErrorMessage,
    );

    handler.next(newError);
  }

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  @override
  Future<Response> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic data,
  }) {
    return _dio.post(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
      data: data,
    );
  }

  @override
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic data,
  }) {
    return _dio.delete(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
      data: data,
    );
  }

  @override
  Future<Response> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic data,
  }) {
    return _dio.put(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
      data: data,
    );
  }

  @override
  Future<Response> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic data,
  }) {
    return _dio.patch(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
      data: data,
    );
  }
}
