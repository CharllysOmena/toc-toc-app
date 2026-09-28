import 'package:flutter/material.dart';

import '../../shared/colors.dart';

class ChecklistFilterBar extends StatelessWidget {
  const ChecklistFilterBar({super.key, required this.selectedDay, required this.onChanged});

  final int? selectedDay;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.chipOff, borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Segment(label: 'Hoje', selected: selectedDay != null, onTap: () => onChanged(DateTime.now().weekday % 7)),
          _Segment(label: 'Todos', selected: selectedDay == null, onTap: () => onChanged(null)),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.panel : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: selected ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.deep : AppColors.inkSoft,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
