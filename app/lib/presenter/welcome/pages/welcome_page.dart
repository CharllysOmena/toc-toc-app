import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/colors.dart';
import '../../shared/widgets/app_cta.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Container(
          width: 300,
          height: 630,
          decoration: BoxDecoration(
            color: AppColors.panel,
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: AppColors.line),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 40,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Container(
                width: 90,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
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
                      style: TextStyle(fontSize: 22, letterSpacing: 5, color: AppColors.inkSoft),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Confira uma vez. Siga em paz.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.inkSoft, fontSize: 15, height: 1.5),
                    ),
                    const Spacer(),
                    AppCta(
                      label: 'Configurar meu checklist',
                      onPressed: () => context.go('/checklist'),
                    ),
                    const AppCtaSub(text: 'leva cerca de 30 segundos'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
