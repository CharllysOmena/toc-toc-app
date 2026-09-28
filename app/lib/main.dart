import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'data/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupDependencies();

  final notifications = GetIt.I<NotificationService>();
  final launchPayload = await notifications.getLaunchPayload();

  final router = createRouter(
    initialLocation: initialLocationForPayload(launchPayload),
  );

  notifications.onSelect = (itemId) => router.go('/check/$itemId');

  runApp(AppWidget(router: router));
}
