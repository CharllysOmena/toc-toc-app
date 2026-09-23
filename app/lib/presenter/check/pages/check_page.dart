import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../shared/colors.dart';
import '../../shared/widgets/confirm_stamp.dart';
import '../bloc/check_bloc.dart';
import '../bloc/check_state.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

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
              const SizedBox(height: 14),
              Expanded(
                child: BlocBuilder<CheckBloc, CheckState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.confirm)),
                      confirmed: (result) {
                        final time = DateFormat('HH:mm').format(result.timestamp);
                        return Column(
                          children: [
                            Expanded(
                              child: ConfirmStamp(timeLabel: '$time · tudo no lugar'),
                            ),
                            const StreakBanner(text: '20 de 20 dias confirmados'),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () => context.go('/history'),
                              child: const Text('Ver histórico', style: TextStyle(color: AppColors.inkSoft)),
                            ),
                          ],
                        );
                      },
                      missing: (result) {
                        final missing = result.missingIds;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: AppColors.alertBg,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                missing.isEmpty ? 'Item não detectado' : '${missing.first[0].toUpperCase()}${missing.first.substring(1)} não detectada',
                                style: const TextStyle(color: AppColors.alert, fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 14),
                            ...result.items.map((item) {
                              final isMissing = missing.contains(item.id);
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: AppColors.line)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${item.emoji} ${item.label}', style: const TextStyle(fontSize: 14)),
                                    Text(
                                      isMissing ? 'não vista' : 'detectada',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                        color: isMissing ? AppColors.alert : AppColors.confirm,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () => context.go('/history'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.inkSoft,
                                  side: const BorderSide(color: AppColors.line),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                                child: const Text('Revisar', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                          ],
                        );
                      },
                      error: (message) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, color: AppColors.alert),
                            const SizedBox(height: 12),
                            Text(message, textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
