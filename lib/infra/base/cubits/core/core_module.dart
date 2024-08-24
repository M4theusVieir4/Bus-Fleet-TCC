import 'package:busbr/domain/interfaces/auth_service_interface.dart';
import 'package:busbr/domain/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<IAuthService>(AuthService.new);
  }
}
