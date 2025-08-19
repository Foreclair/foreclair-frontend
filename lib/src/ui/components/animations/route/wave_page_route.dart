import 'dart:math' as math;

import 'package:flutter/material.dart';

class WavePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  WavePageRoute({required this.page})
    : super(
        transitionDuration: Duration(milliseconds: 750),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, childAnim) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: ClipPath(
                      clipper: WaveClipper(animation.value),
                      child: Container(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  FadeTransition(opacity: animation, child: child),
                ],
              );
            },
            child: child,
          );
        },
      );
}

class WaveClipper extends CustomClipper<Path> {
  final double progress;

  WaveClipper(this.progress);

  @override
  Path getClip(Size size) {
    final path = Path();
    final waveHeight = size.height * (1 - progress);
    const waveAmplitude = 30.0;
    const waveFrequency = 2.0;

    path.moveTo(0, waveHeight);

    for (double x = 0; x <= size.width; x++) {
      double y = waveHeight + math.sin((x / size.width * math.pi * waveFrequency) + (progress * math.pi * 2)) * waveAmplitude;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => progress != oldClipper.progress;
}
