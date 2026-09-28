import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/checklist_item.dart';
import '../../shared/colors.dart';
import '../bloc/checklist_bloc.dart';
import '../bloc/checklist_event.dart';
import '../bloc/checklist_state.dart';
import '../widgets/checklist_filter_bar.dart';
import '../widgets/checklist_item_tile.dart';
import '../widgets/checklist_period.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ChecklistBloc>().add(const ChecklistEvent.started());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Checklist'),
        backgroundColor: AppColors.bg,
        foregroundColor: AppColors.ink,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/checklist/new'),
        backgroundColor: AppColors.deep,
        foregroundColor: const Color(0xFFF5F3EC),
        icon: const Icon(Icons.add),
        label: const Text('Novo item'),
      ),
      body: BlocBuilder<ChecklistBloc, ChecklistState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.confirm)),
            error: (message) => Center(child: Text(message)),
            ready: (items, selectedDay) {
              final filtered = selectedDay == null ? items : items.where((e) => e.weekDays.contains(selectedDay)).toList();
              if (filtered.isEmpty) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: ChecklistFilterBar(
                        selectedDay: selectedDay,
                        onChanged: (day) => context.read<ChecklistBloc>().add(ChecklistEvent.filterChanged(day)),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.checklist, size: 48, color: AppColors.inkSoft),
                              const SizedBox(height: 12),
                              Text(selectedDay == null ? 'Nenhum item ainda' : 'Nenhum item para hoje', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.ink)),
                              const SizedBox(height: 8),
                              const Text('Toque em Novo item para adicionar', textAlign: TextAlign.center, style: TextStyle(color: AppColors.inkSoft)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              final grouped = _groupByPeriod(filtered);
              final total = filtered.length;
              final registeredCount = filtered.where((e) => e.isRegisteredToday(DateTime.now())).length;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Row(
                      children: [
                        ChecklistFilterBar(
                          selectedDay: selectedDay,
                          onChanged: (day) => context.read<ChecklistBloc>().add(ChecklistEvent.filterChanged(day)),
                        ),
                        const Spacer(),
                        Text('$registeredCount/$total', style: const TextStyle(color: AppColors.inkSoft, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => context.read<ChecklistBloc>().add(const ChecklistEvent.started()),
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                        itemCount: grouped.length,
                        itemBuilder: (context, index) {
                          final entry = grouped[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
                                child: Text(periodLabel(entry.key), style: const TextStyle(color: AppColors.inkSoft, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                              ),
                              Column(
                                children: [
                                  for (var i = 0; i < entry.value.length; i++) ...[
                                    if (i > 0) const SizedBox(height: 12),
                                    Builder(
                                      builder: (context) {
                                        final item = entry.value[i];
                                        return ChecklistItemTile(
                                          item: item,
                                          onTap: () {
                                            final canRegister = item.canRegisterAt(DateTime.now());
                                            final registered = item.isRegisteredToday(DateTime.now());
                                            if (registered || canRegister) {
                                              // ignore: discarded_futures
                                              context.push('/check/${item.id}');
                                            } else {
                                              final reason = item.registerBlockReason(DateTime.now());
                                              if (reason != null) {
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(reason)));
                                              }
                                            }
                                          },
                                          onEdit: () => context.push('/checklist/${item.id}/edit'),
                                          onDelete: () => context.read<ChecklistBloc>().add(ChecklistEvent.deleted(item.id)),
                                          onHistory: () => context.push('/history/${item.id}'),
                                        );
                                      },
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          );
                        },
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

  List<MapEntry<ChecklistPeriod, List<ChecklistItem>>> _groupByPeriod(List<ChecklistItem> items) {
    final sorted = List<ChecklistItem>.from(items)..sort((a, b) => a.time.hour * 60 + a.time.minute - (b.time.hour * 60 + b.time.minute));
    final map = <ChecklistPeriod, List<ChecklistItem>>{};
    for (final item in sorted) {
      final p = periodForHour(item.time.hour);
      map.putIfAbsent(p, () => []).add(item);
    }
    final order = [ChecklistPeriod.morning, ChecklistPeriod.afternoon, ChecklistPeriod.evening];
    return order.where((p) => map.containsKey(p)).map((p) => MapEntry(p, map[p]!)).toList();
  }
}
