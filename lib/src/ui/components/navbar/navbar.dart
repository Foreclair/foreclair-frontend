import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/assets/colors/snsm_colors.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 20, offset: const Offset(0, 6))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item(icon: CupertinoIcons.house_fill, label: "Dashboard", index: 0),
            _item(icon: CupertinoIcons.person_3_fill, label: "Effectifs", index: 1),
            _item(icon: CupertinoIcons.cloud_sun_fill, label: "Météo", index: 2),
            _item(icon: CupertinoIcons.graph_square_fill, label: "Statistiques", index: 3),
            _item(icon: CupertinoIcons.settings, label: "Paramètres", index: 4),
          ],
        ),
      ),
    );
  }

  Widget _item({required IconData icon, required String label, required int index}) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? SNSMColors.bleuClair.withAlpha(30) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? SNSMColors.bleuOcean : Colors.grey),
            if (isSelected) ...[const SizedBox(width: 6), Text(label, style: const TextStyle(color: SNSMColors.bleuClair))],
          ],
        ),
      ),
    );
  }
}
