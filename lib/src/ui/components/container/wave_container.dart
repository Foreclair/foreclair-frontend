import 'package:flutter/material.dart';

class InvertedWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Commence en haut à gauche à la hauteur de la vague
    path.moveTo(0, 40);

    // Création de la vague en haut avec des courbes de Bézier
    path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 40);
    path.quadraticBezierTo(3 / 4 * size.width, 80, size.width, 40);

    // Descend vers le coin inférieur droit
    path.lineTo(size.width, size.height);

    // Ligne vers le coin inférieur gauche
    path.lineTo(0, size.height);

    // Fermeture du chemin
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveContainer extends StatelessWidget {
  final Widget child;
  final double height;

  const WaveContainer({super.key, required this.child, this.height = 650});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: InvertedWaveClipper(),
        child: Container(color: Theme.of(context).colorScheme.surface, height: height, width: double.infinity, child: child),
      ),
    );
  }
}
