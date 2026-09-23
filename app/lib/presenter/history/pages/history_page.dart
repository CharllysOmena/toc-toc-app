import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/colors.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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
                child: BlocBuilder<HistoryBloc, HistoryState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (message) => Center(child: Text(message)),
                      ready: (entries) {
                        final confirmed = entries.where((e) => e.confirmed).length;
                        final total = entries.length;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => context.go('/'),
                                  icon: const Icon(Icons.arrow_back, size: 20),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const SizedBox(width: 12),
                                const Text('Seu histórico', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$confirmed/$total',
                              style: GoogleFonts.fraunces(fontSize: 42, fontWeight: FontWeight.w500, color: AppColors.ink),
                            ),
                            const Text('dias confirmados este mês', style: TextStyle(color: AppColors.inkSoft, fontSize: 13.5)),
                            const SizedBox(height: 18),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                ),
                                itemCount: entries.length,
                                itemBuilder: (context, index) {
                                  final e = entries[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: e.confirmed ? AppColors.confirmBg : AppColors.chipOff,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: e.confirmed
                                          ? const Text('✓', style: TextStyle(color: AppColors.confirm, fontSize: 11))
                                          : const SizedBox.shrink(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () => context.go('/'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.inkSoft,
                                  side: const BorderSide(color: AppColors.line),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                                child: const Text('Voltar ao início'),
                              ),
                            ),
                          ],
                        );
                      },
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
