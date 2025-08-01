import 'package:blues/ui/views/authentication/login_view.dart';
import 'package:blues/utils/colors/snsm_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ThemeMode.light;

    return MaterialApp(
      title: 'Blues Online',
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: snsmLightColorScheme,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: SNSMColors.bleuMarin,
          foregroundColor: SNSMColors.blanc,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: SNSMColors.rouge,
            foregroundColor: SNSMColors.blanc,
            elevation: 3,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: SNSMColors.orange,
          foregroundColor: SNSMColors.blanc,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: snsmDarkColorScheme,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const LoginView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
