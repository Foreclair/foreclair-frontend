import 'package:flutter/material.dart';

class LogBookActionPage extends StatelessWidget {
  const LogBookActionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("Nouvelle Action"),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
      ),
      body: const Center(
        child: Text("Page des actions de la main courante", style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}
