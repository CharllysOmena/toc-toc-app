import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/check_repository_impl.dart';
import 'data/repositories/checklist_repository_impl.dart';
import 'data/repositories/history_repository_impl.dart';
import 'data/repositories/onboarding_repository_impl.dart';
import 'data/services/camera_service.dart';
import 'data/services/check_ai_service.dart';
import 'data/services/notification_service.dart';
import 'data/services/photo_storage.dart';
import 'data/services/preferences_service.dart';
import 'domain/repositories/check_repository.dart';
import 'domain/repositories/checklist_repository.dart';
import 'domain/repositories/history_repository.dart';
import 'domain/repositories/onboarding_repository.dart';
import 'presenter/check/bloc/check_bloc.dart';
import 'presenter/check/bloc/check_event.dart';
import 'presenter/check/pages/check_page.dart';
import 'presenter/checklist/bloc/checklist_bloc.dart';
import 'presenter/checklist/bloc/checklist_event.dart';
import 'presenter/checklist/bloc/checklist_form_bloc.dart';
import 'presenter/checklist/bloc/checklist_form_event.dart';
import 'presenter/checklist/pages/checklist_item_form_page.dart';
import 'presenter/checklist/pages/checklist_page.dart';
import 'presenter/history/bloc/history_bloc.dart';
import 'presenter/history/bloc/history_event.dart';
import 'presenter/history/pages/history_page.dart';
import 'presenter/welcome/pages/welcome_page.dart';

Future<void> setupDependencies() async {
  final getIt = GetIt.instance;

  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  getIt.registerLazySingleton<PreferencesService>(() => PreferencesServiceImpl(prefs));

  getIt.registerLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(getIt<PreferencesService>()));
  getIt.registerLazySingleton<ChecklistRepository>(() => ChecklistRepositoryImpl(getIt<PreferencesService>()));
  getIt.registerLazySingleton<CheckAiService>(() => CheckAiServiceImpl());
  getIt.registerLazySingleton<CheckRepository>(() => CheckRepositoryImpl(getIt<ChecklistRepository>(), getIt<CheckAiService>()));
  getIt.registerLazySingleton<HistoryRepository>(() => HistoryRepositoryImpl(getIt<PreferencesService>()));

  getIt.registerLazySingleton<CameraService>(() => CameraServiceImpl());
  getIt.registerLazySingleton<PhotoStorage>(() => PhotoStorageImpl());
  final notificationService = NotificationServiceImpl();
  await notificationService.init();
  getIt.registerLazySingleton<NotificationService>(() => notificationService);

  getIt.registerLazySingleton<ChecklistBloc>(() => ChecklistBloc(getIt<ChecklistRepository>(), getIt<NotificationService>()));
  getIt.registerFactory<ChecklistFormBloc>(() => ChecklistFormBloc(getIt<ChecklistRepository>(), getIt<NotificationService>()));
}

String? initialLocationForPayload(String? itemId) {
  if (itemId == null || itemId.trim().isEmpty) return null;
  return '/check/${Uri.encodeComponent(itemId)}';
}

GoRouter createRouter({String? initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation ?? '/checklist',
    redirect: (context, state) async {
      final onboarding = GetIt.I<OnboardingRepository>();
      final hasSeen = await onboarding.hasSeenWelcome();
      final isWelcome = state.matchedLocation == '/welcome';
      if (!hasSeen && !isWelcome) {
        return Uri(
          path: '/welcome',
          queryParameters: {'from': state.uri.toString()},
        ).toString();
      }
      if (hasSeen && isWelcome) {
        final from = state.uri.queryParameters['from'];
        return (from == null || from.isEmpty) ? '/checklist' : from;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/checklist',
        name: 'checklist',
        builder: (context, state) => BlocProvider.value(
          value: GetIt.I<ChecklistBloc>()..add(const ChecklistEvent.started()),
          child: const ChecklistPage(),
        ),
      ),
      GoRoute(
        path: '/checklist/new',
        name: 'checklist_new',
        builder: (context, state) => BlocProvider(
          create: (_) => GetIt.I<ChecklistFormBloc>()..add(const ChecklistFormEvent.started(null)),
          child: const ChecklistItemFormPage(),
        ),
      ),
      GoRoute(
        path: '/checklist/:id/edit',
        name: 'checklist_edit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider(
            create: (_) => GetIt.I<ChecklistFormBloc>()..add(ChecklistFormEvent.started(id)),
            child: ChecklistItemFormPage(itemId: id),
          );
        },
      ),
      GoRoute(
        path: '/check/:itemId',
        name: 'check',
        builder: (context, state) {
          final itemId = state.pathParameters['itemId']!;
          return BlocProvider(
            create: (_) => CheckBloc(GetIt.I<CheckRepository>(), GetIt.I<HistoryRepository>(), GetIt.I<ChecklistRepository>(), GetIt.I<PhotoStorage>(), itemId)..add(const CheckEvent.started()),
            child: CheckPage(itemId: itemId),
          );
        },
      ),
      GoRoute(
        path: '/history/:itemId',
        name: 'history',
        builder: (context, state) {
          final itemId = state.pathParameters['itemId']!;
          return BlocProvider(
            create: (_) => HistoryBloc(GetIt.I<HistoryRepository>(), itemId)..add(const HistoryEvent.started()),
            child: HistoryPage(itemId: itemId),
          );
        },
      ),
      GoRoute(
        path: '/',
        redirect: (context, state) => '/checklist',
      ),
    ],
  );
}
