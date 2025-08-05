import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopographyBackground extends StatelessWidget {
  final Widget? child;

  const TopographyBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Theme.of(context).colorScheme.surfaceContainerHighest),
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/svg/topography.svg',
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(Color(0xF2A1A1A1), BlendMode.srcIn),
          ),
        ),
        // Optional foreground content
        if (child != null) child!,
      ],
    );
  }
}
