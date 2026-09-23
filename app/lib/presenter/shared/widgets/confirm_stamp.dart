import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class ConfirmStamp extends StatelessWidget {
  const ConfirmStamp({super.key, required this.timeLabel});

  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 168,
          height: 168,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.confirm, width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('✓', style: TextStyle(fontSize: 42, color: AppColors.confirm, height: 1)),
              const SizedBox(height: 4),
              Text(
                'Confirmado',
                style: GoogleFonts.fraunces(fontSize: 17, color: AppColors.confirm),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          timeLabel,
          style: const TextStyle(color: AppColors.inkSoft, fontSize: 13.5),
        ),
      ],
    );
  }
}

class StreakBanner extends StatelessWidget {
  const StreakBanner({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.confirmBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.deep, fontSize: 13.5, fontWeight: FontWeight.w600),
      ),
    );
  }
}
