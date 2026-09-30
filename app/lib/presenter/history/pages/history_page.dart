import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/repositories/checklist_repository.dart';
import '../../shared/colors.dart';
import '../../shared/widgets/app_cta.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.panel,
      appBar: AppBar(
        title: FutureBuilder(
          future: GetIt.I<ChecklistRepository>().getById(itemId),
          builder: (context, snapshot) {
            final title = snapshot.data?.title ?? 'Seu histórico';
            return Text(title, overflow: TextOverflow.ellipsis);
          },
        ),
        backgroundColor: AppColors.panel,
        foregroundColor: AppColors.ink,
        iconTheme: const IconThemeData(color: AppColors.ink, size: 24),
        titleTextStyle: const TextStyle(
          color: AppColors.ink,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () => context.go('/checklist'),
        ),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.confirm),
            ),
            error: (message) => Center(child: Text(message)),
            ready: (entries) {
              final now = DateTime.now();
              final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
              final firstWeekday = DateTime(now.year, now.month, 1).weekday % 7;
              final confirmedSet = entries
                  .where((e) => e.confirmed)
                  .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
                  .toSet();
              final manualSet = entries
                  .where((e) => e.confirmed && e.manual)
                  .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
                  .toSet();
              final hasManual = manualSet.isNotEmpty;
              final confirmedThisMonth = entries
                  .where(
                    (e) =>
                        e.confirmed &&
                        e.date.year == now.year &&
                        e.date.month == now.month,
                  )
                  .length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$confirmedThisMonth/$daysInMonth',
                          style: GoogleFonts.fraunces(
                            fontSize: 42,
                            fontWeight: FontWeight.w500,
                            color: AppColors.ink,
                          ),
                        ),
                        const Text(
                          'dias confirmados este mês',
                          style: TextStyle(
                            color: AppColors.inkSoft,
                            fontSize: 13.5,
                          ),
                        ),
                        if (hasManual) ...[
                          const SizedBox(height: 6),
                          const Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 12,
                                color: AppColors.confirm,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'inclui confirmações manuais',
                                style: TextStyle(
                                  color: AppColors.inkSoft,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'D',
                          style: TextStyle(
                            color: AppColors.inkSoft,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'S',
                          style: TextStyle(
                            color: AppColors.inkSoft,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'T',
                          style: TextStyle(
                            color: AppColors.inkSoft,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Q',
                          style: TextStyle(
                            color: AppColors.inkSoft,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Q',
                          style: TextStyle(
                            color: AppColors.inkSoft,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'S',
                          style: TextStyle(
                            color: AppColors.inkSoft,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'S',
                          style: TextStyle(
                            color: AppColors.inkSoft,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                            ),
                        itemCount: firstWeekday + daysInMonth,
                        itemBuilder: (context, index) {
                          if (index < firstWeekday) {
                            return const SizedBox.shrink();
                          }
                          final day = index - firstWeekday + 1;
                          final date = DateTime(now.year, now.month, day);
                          final isFuture = date.isAfter(
                            DateTime(now.year, now.month, now.day),
                          );
                          final isConfirmed = confirmedSet.any(
                            (d) =>
                                d.year == date.year &&
                                d.month == date.month &&
                                d.day == date.day,
                          );
                          final isManual = manualSet.any(
                            (d) =>
                                d.year == date.year &&
                                d.month == date.month &&
                                d.day == date.day,
                          );
                          final isToday =
                              date.year == now.year &&
                              date.month == now.month &&
                              date.day == now.day;

                          Color bg;
                          Widget child;
                          if (isConfirmed) {
                            bg = AppColors.confirmBg;
                            child = Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$day',
                                  style: const TextStyle(
                                    color: AppColors.confirm,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                isManual
                                    ? const Icon(
                                        Icons.edit,
                                        size: 8,
                                        color: AppColors.confirm,
                                      )
                                    : const Text(
                                        '✓',
                                        style: TextStyle(
                                          color: AppColors.confirm,
                                          fontSize: 8,
                                        ),
                                      ),
                              ],
                            );
                          } else if (isFuture) {
                            bg = Colors.transparent;
                            child = Text(
                              '$day',
                              style: const TextStyle(
                                color: AppColors.inkSoft,
                                fontSize: 11,
                              ),
                            );
                          } else {
                            bg = AppColors.chipOff;
                            child = Text(
                              '$day',
                              style: TextStyle(
                                color: isToday
                                    ? AppColors.deep
                                    : AppColors.inkSoft,
                                fontSize: 11,
                                fontWeight: isToday
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
                            );
                          }

                          return Container(
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(6),
                              border: isToday
                                  ? Border.all(
                                      color: AppColors.confirm,
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Center(child: child),
                          );
                        },
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                      child: AppSecondaryButton(
                        label: 'Voltar à lista',
                        onPressed: () => context.go('/checklist'),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
