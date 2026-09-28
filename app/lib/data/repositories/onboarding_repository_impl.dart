import '../../domain/repositories/onboarding_repository.dart';
import '../services/preferences_service.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._prefs);

  final PreferencesService _prefs;
  static const _key = 'toc_welcome_seen';

  @override
  Future<bool> hasSeenWelcome() async {
    final v = await _prefs.getBool(_key);
    return v ?? false;
  }

  @override
  Future<void> setSeenWelcome() async {
    await _prefs.setBool(_key, true);
  }
}
