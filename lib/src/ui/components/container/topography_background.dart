import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopographyBackground extends StatelessWidget {
  final Widget? child;
  final List<Color> backgroundColors;
  final ColorFilter lineColorFilter;

  const TopographyBackground({
    super.key,
    this.child,
    required this.backgroundColors,
    this.lineColorFilter = const ColorFilter.mode(Color(0xF2A1A1A1), BlendMode.srcIn),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: backgroundColors)),
        ),
        Positioned.fill(
          child: SvgPicture.asset('assets/svg/topography.svg', fit: BoxFit.cover, colorFilter: lineColorFilter),
        ),
        if (child != null) child!,
      ],
    );
  }
}
