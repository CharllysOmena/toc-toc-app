import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/repositories/onboarding_repository.dart';
import '../../shared/colors.dart';
import '../../shared/widgets/app_cta.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final from = GoRouterState.of(context).uri.queryParameters['from'];
    return Scaffold(
      backgroundColor: AppColors.panel,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Toc Toc',
                        style: GoogleFonts.fraunces(
                          fontSize: 38,
                          fontWeight: FontWeight.w500,
                          color: AppColors.ink,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Text(
                        '• •',
                        style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 5,
                          color: AppColors.inkSoft,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Confira uma vez. Siga em paz.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.inkSoft,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppCta(
                label: 'Começar',
                onPressed: () async {
                  await GetIt.I<OnboardingRepository>().setSeenWelcome();
                  if (context.mounted) context.go(from ?? '/checklist');
                },
              ),
              const AppCtaSub(text: 'crie seu primeiro checklist'),
            ],
          ),
        ),
      ),
    );
  }
}
