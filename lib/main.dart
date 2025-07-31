import 'package:blues/ui/views/authentication/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blues Online',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 51, 97, 1.0))),
      home: const LoginView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
