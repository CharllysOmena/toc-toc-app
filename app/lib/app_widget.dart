import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'presenter/shared/themes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Toc Toc',
      theme: AppThemes.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
