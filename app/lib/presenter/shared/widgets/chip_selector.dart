import 'package:flutter/material.dart';

import '../colors.dart';

class ChipSelector extends StatelessWidget {
  const ChipSelector({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.confirmBg : AppColors.chipOff,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.confirm : AppColors.line,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: selected ? AppColors.confirm : AppColors.inkSoft,
          ),
        ),
      ),
    );
  }
}
