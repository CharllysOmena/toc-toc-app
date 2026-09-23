import 'package:flutter/material.dart';

import '../colors.dart';

class AppFrame extends StatelessWidget {
  const AppFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.bg),
      child: SafeArea(
        child: Center(
          child: Container(
            width: 300,
            height: 630,
            decoration: BoxDecoration(
              color: AppColors.panel,
              borderRadius: BorderRadius.circular(34),
              border: Border.all(color: AppColors.line),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x1419190F).withValues(alpha: 0.12),
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
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(14)),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
