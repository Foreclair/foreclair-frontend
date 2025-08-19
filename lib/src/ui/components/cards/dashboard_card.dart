import 'package:flutter/material.dart';

import '../../../../assets/colors/snsm_colors.dart';

class DashboardCard extends StatelessWidget {
  final BuildContext context;
  final Widget child;
  final Color color;
  final VoidCallback onTap;
  final double width;

  const DashboardCard({
    super.key,
    required this.context,
    required this.child,
    required this.color,
    required this.onTap,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 10, offset: const Offset(0, 4))],
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: child),
            Icon(Icons.arrow_forward_ios, size: 16, color: SNSMColors.gris),
          ],
        ),
      ),
    );
  }
}
