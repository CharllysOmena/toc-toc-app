import 'package:flutter/material.dart';

import '../../../domain/entities/checklist_item.dart';
import '../../../domain/entities/day_time.dart';
import '../../../domain/entities/monitored_object.dart';
import '../../shared/colors.dart';

class ChecklistItemTile extends StatelessWidget {
  const ChecklistItemTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onHistory,
  });

  final ChecklistItem item;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    final object = MonitoredObjects.byId(item.objectId);
    final now = DateTime.now();
    final registered = item.isRegisteredToday(now);
    final canRegister = item.canRegisterAt(now);
    final blockReason = item.registerBlockReason(now);
    final time = item.time.format();

    final accent = registered
        ? AppColors.confirm
        : canRegister
            ? AppColors.deep
            : AppColors.line;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Excluir item?'),
            content: Text('Remover "${item.title}" permanentemente?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
              FilledButton(onPressed: () => Navigator.pop(context, true), style: FilledButton.styleFrom(backgroundColor: AppColors.alert), child: const Text('Excluir')),
            ],
          ),
        );
        return confirmed ?? false;
      },
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: AppColors.alert, borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: registered ? AppColors.confirmBg : AppColors.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border(left: BorderSide(color: accent, width: 3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: registered ? AppColors.confirm.withValues(alpha: 0.12) : AppColors.chipOff,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(object.emoji, style: const TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.ink))),
                          if (registered)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: AppColors.confirm, borderRadius: BorderRadius.circular(12)),
                              child: const Text('Registrado', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                            )
                          else if (!canRegister)
                            const Icon(Icons.lock_outline, size: 14, color: AppColors.inkSoft),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text('$time • ${object.label}', style: const TextStyle(color: AppColors.inkSoft, fontSize: 12)),
                      if (!registered && blockReason != null) ...[
                        const SizedBox(height: 4),
                        Text(blockReason, style: const TextStyle(color: AppColors.alert, fontSize: 11, fontWeight: FontWeight.w500)),
                      ],
                    ],
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 20, color: AppColors.inkSoft),
                tooltip: 'Ações',
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      onEdit();
                      break;
                    case 'history':
                      onHistory();
                      break;
                    case 'delete':
                      onDelete();
                      break;
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'edit', child: Text('Editar')),
                  PopupMenuItem(value: 'history', child: Text('Histórico')),
                  PopupMenuItem(value: 'delete', child: Text('Excluir', style: TextStyle(color: AppColors.alert))),
                ],
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, size: 18, color: AppColors.inkSoft),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
