abstract class OnboardingRepository {
  Future<bool> hasSeenWelcome();
  Future<void> setSeenWelcome();
}
