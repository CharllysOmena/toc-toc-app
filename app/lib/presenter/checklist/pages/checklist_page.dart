import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../shared/colors.dart';
import '../../shared/widgets/app_cta.dart';
import '../../shared/widgets/chip_selector.dart';
import '../../shared/widgets/viewfinder.dart';
import '../bloc/checklist_bloc.dart';
import '../bloc/checklist_event.dart';
import '../bloc/checklist_state.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

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
                child: BlocBuilder<ChecklistBloc, ChecklistState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      saving: (items) => _Content(items: items, saving: true),
                      ready: (items) => _Content(items: items, saving: false),
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

class _Content extends StatelessWidget {
  const _Content({required this.items, required this.saving});

  final List<dynamic> items;
  final bool saving;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aponte para o lugar de sempre',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: AppColors.ink),
        ),
        const SizedBox(height: 4),
        const Text(
          'A mesa, o gancho, a bandeja de entrada — onde você deixa as coisas antes de sair.',
          style: TextStyle(color: AppColors.inkSoft, fontSize: 13, height: 1.45),
        ),
        const SizedBox(height: 12),
        const Viewfinder(),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final label = '${item.emoji} ${item.label}';
            return ChipSelector(
              label: label,
              selected: item.selected as bool,
              onTap: () => context.read<ChecklistBloc>().add(ChecklistEvent.toggled(item.id as String)),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        AppCta(
          label: saving ? 'Salvando...' : 'Salvar checklist',
          onPressed: saving
              ? null
              : () {
                  context.read<ChecklistBloc>().add(const ChecklistEvent.saved());
                  context.go('/check');
                },
        ),
      ],
    );
  }
}
