import 'package:blues/utils/topography_background.dart';
import 'package:blues/utils/wave_container.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: TopographyBackground(
        child: WaveContainer(
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [Text("Login")]),
          ),
        ),
      ),
    );
  }
}
