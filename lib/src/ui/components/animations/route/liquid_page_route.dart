import 'package:flutter/material.dart';

class LiquidPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  LiquidPageRoute({required this.page})
    : super(
        transitionDuration: const Duration(milliseconds: 900),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, childAnim) {
                    return ClipPath(
                      clipper: CircleRevealClipper(animation.value),
                      child: Container(color: Theme.of(context).colorScheme.primary),
                    );
                  },
                ),
              ),
              FadeTransition(opacity: animation, child: child),
            ],
          );
        },
      );
}

class CircleRevealClipper extends CustomClipper<Path> {
  final double revealPercent;

  CircleRevealClipper(this.revealPercent);

  @override
  Path getClip(Size size) {
    final epicenter = Offset(size.width / 2, size.height - 56);
    final radius = size.longestSide * revealPercent;
    return Path()..addOval(Rect.fromCircle(center: epicenter, radius: radius));
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return revealPercent != oldClipper.revealPercent;
  }
}
