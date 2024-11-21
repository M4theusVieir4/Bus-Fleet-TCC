import 'package:busbr/data/repositories/auth_repository.dart';
import 'package:busbr/domain/interfaces/repositories/auth_repository_interface.dart';
import 'package:busbr/domain/interfaces/services/auth_service_interface.dart';
import 'package:busbr/domain/services/auth_service.dart';
import 'package:busbr/infra/config/network/response/client/dio/http_client.dart';
import 'package:busbr/infra/config/network/response/client/http_client_interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add(() => Dio());
    //i.add(FirebaseCrashlyticsService.new);
  }

  @override
  void binds(Injector i) {
    i.addLazySingleton<IHttpClient>(HttpClient.new);
    i.addLazySingleton<IAuthService>(AuthService.new);
    i.addLazySingleton<IAuthRepository>(AuthRepository.new);
  }
}
