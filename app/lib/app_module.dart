import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'data/repositories/check_repository_impl.dart';
import 'data/repositories/checklist_repository_impl.dart';
import 'data/repositories/history_repository_impl.dart';
import 'data/services/http_client_service.dart';
import 'domain/repositories/check_repository.dart';
import 'domain/repositories/checklist_repository.dart';
import 'domain/repositories/history_repository.dart';
import 'presenter/check/bloc/check_bloc.dart';
import 'presenter/check/bloc/check_event.dart';
import 'presenter/check/pages/check_page.dart';
import 'presenter/checklist/bloc/checklist_bloc.dart';
import 'presenter/checklist/bloc/checklist_event.dart';
import 'presenter/checklist/pages/checklist_page.dart';
import 'presenter/history/bloc/history_bloc.dart';
import 'presenter/history/bloc/history_event.dart';
import 'presenter/history/pages/history_page.dart';
import 'presenter/welcome/pages/welcome_page.dart';

Future<void> setupDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<Dio>(
    () {
      final dio = Dio(
        BaseOptions(
          baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'https://api.example.com'),
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
      return dio;
    },
  );

  getIt.registerLazySingleton<HttpClientService>(
    () => HttpClientServiceImpl(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<ChecklistRepository>(
    () => ChecklistRepositoryImpl(),
  );

  getIt.registerLazySingleton<CheckRepository>(
    () => CheckRepositoryImpl(getIt<ChecklistRepository>()),
  );

  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(),
  );

  getIt.registerFactory<ChecklistBloc>(() => ChecklistBloc(getIt<ChecklistRepository>()));
  getIt.registerFactory<CheckBloc>(() => CheckBloc(getIt<CheckRepository>(), getIt<HistoryRepository>()));
  getIt.registerFactory<HistoryBloc>(() => HistoryBloc(getIt<HistoryRepository>()));
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/checklist',
        name: 'checklist',
        builder: (context, state) => BlocProvider(
          create: (_) => GetIt.I<ChecklistBloc>()..add(const ChecklistEvent.started()),
          child: const ChecklistPage(),
        ),
      ),
      GoRoute(
        path: '/check',
        name: 'check',
        builder: (context, state) => BlocProvider(
          create: (_) => GetIt.I<CheckBloc>()..add(const CheckEvent.started()),
          child: const CheckPage(),
        ),
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => BlocProvider(
          create: (_) => GetIt.I<HistoryBloc>()..add(const HistoryEvent.started()),
          child: const HistoryPage(),
        ),
      ),
    ],
  );
}
