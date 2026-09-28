import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/day_time.dart';
import '../../../domain/entities/monitored_object.dart';
import '../../shared/colors.dart';
import '../../shared/widgets/app_cta.dart';
import '../bloc/checklist_form_bloc.dart';
import '../bloc/checklist_form_event.dart';
import '../bloc/checklist_form_state.dart';

class ChecklistItemFormPage extends StatefulWidget {
  const ChecklistItemFormPage({super.key, this.itemId});

  final String? itemId;

  @override
  State<ChecklistItemFormPage> createState() => _ChecklistItemFormPageState();
}

class _ChecklistItemFormPageState extends State<ChecklistItemFormPage> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.panel,
      appBar: AppBar(
        title: Text(widget.itemId == null ? 'Novo item' : 'Editar item'),
        backgroundColor: AppColors.panel,
        foregroundColor: AppColors.ink,
        centerTitle: true,
      ),
      body: BlocConsumer<ChecklistFormBloc, ChecklistFormState>(
        listener: (context, state) {
          state.maybeWhen(
            success: () => context.go('/checklist'),
            error: (message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message))),
            orElse: () {},
          );
          state.maybeMap(
            ready: (s) {
              if (_titleController.text != s.title) {
                _titleController.text = s.title;
                _titleController.selection = TextSelection.fromPosition(TextPosition(offset: _titleController.text.length));
              }
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.confirm)),
            ready: (id, title, objectId, time, weekDays, error) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(labelText: 'Título', hintText: 'Ex: Fechar porta'),
                            onChanged: (v) => context.read<ChecklistFormBloc>().add(ChecklistFormEvent.titleChanged(v)),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            initialValue: objectId,
                            decoration: const InputDecoration(labelText: 'Objeto para checagem por IA'),
                            items: MonitoredObjects.all
                                .map((o) => DropdownMenuItem(value: o.id, child: Text('${o.emoji} ${o.label}')))
                                .toList(),
                            onChanged: (v) {
                              if (v != null) context.read<ChecklistFormBloc>().add(ChecklistFormEvent.objectChanged(v));
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    final picked = await showTimePicker(context: context, initialTime: TimeOfDay(hour: time.hour, minute: time.minute));
                                    if (picked != null && context.mounted) {
                                      context.read<ChecklistFormBloc>().add(ChecklistFormEvent.timeChanged(picked.toDayTime()));
                                    }
                                  },
                                  icon: const Icon(Icons.access_time, size: 18),
                                  label: Text(time.format()),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('Dias para lembrar', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.ink)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: List.generate(7, (i) {
                              const labels = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
                              final selected = weekDays.contains(i);
                              return FilterChip(
                                label: Text(labels[i]),
                                selected: selected,
                                onSelected: (_) => context.read<ChecklistFormBloc>().add(ChecklistFormEvent.weekDayToggled(i)),
                                selectedColor: AppColors.confirmBg,
                                checkmarkColor: AppColors.confirm,
                              );
                            }),
                          ),
                          if (error != null) ...[
                            const SizedBox(height: 8),
                            Text(error, style: const TextStyle(color: AppColors.alert, fontSize: 12)),
                          ],
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                      child: AppCta(
                        label: 'Salvar',
                        onPressed: () => context.read<ChecklistFormBloc>().add(const ChecklistFormEvent.saved()),
                      ),
                    ),
                  ),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

extension on TimeOfDay {
  DayTime toDayTime() => DayTime(hour: hour, minute: minute);
}
