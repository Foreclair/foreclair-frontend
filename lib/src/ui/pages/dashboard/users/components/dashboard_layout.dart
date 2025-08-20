import 'package:flutter/material.dart';

class DashboardLayout extends StatelessWidget {
  final double height;
  final List<Widget> children;

  const DashboardLayout({super.key, required this.height, this.children = const []});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.clamp,
              colors: [theme.colorScheme.primaryContainer, theme.colorScheme.primaryContainer.withAlpha(250)],
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(35)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ),
      ],
    );
  }
}
