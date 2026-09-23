import 'package:flutter/material.dart';

import '../colors.dart';

class Viewfinder extends StatelessWidget {
  const Viewfinder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFFE4E7DD), Color(0xFFDCDFD3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Stack(
          children: [
            _Corner(top: 12, left: 12, borderTop: true, borderLeft: true),
            _Corner(top: 12, right: 12, borderTop: true, borderRight: true),
            _Corner(bottom: 12, left: 12, borderBottom: true, borderLeft: true),
            _Corner(bottom: 12, right: 12, borderBottom: true, borderRight: true),
          ],
        ),
      ),
    );
  }
}

class _Corner extends StatelessWidget {
  const _Corner({this.top, this.left, this.right, this.bottom, this.borderTop = false, this.borderLeft = false, this.borderRight = false, this.borderBottom = false});

  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final bool borderTop;
  final bool borderLeft;
  final bool borderRight;
  final bool borderBottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          border: Border(
            top: borderTop ? const BorderSide(color: AppColors.deep, width: 3) : BorderSide.none,
            left: borderLeft ? const BorderSide(color: AppColors.deep, width: 3) : BorderSide.none,
            right: borderRight ? const BorderSide(color: AppColors.deep, width: 3) : BorderSide.none,
            bottom: borderBottom ? const BorderSide(color: AppColors.deep, width: 3) : BorderSide.none,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
