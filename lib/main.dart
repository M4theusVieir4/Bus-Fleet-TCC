import 'package:busbr/app_module.dart';
import 'package:busbr/app_widget.dart';
import 'package:busbr/firebase_options.dart';
import 'package:busbr/infra/utils/notifications/push_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Future.wait([
    PushNotificationsService.initialize(),
  ]);

  runApp(ModularApp(
    module: AppModule(),
    child: AppWidget(),
  ));
}
