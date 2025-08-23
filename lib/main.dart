import 'package:flutter/material.dart';
import 'package:foreclair/src/data/providers/navigation_provider.dart';
import 'package:foreclair/src/ui/views/authentication/login_gateway.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'assets/colors/snsm_colors.dart';

void main() {
  Intl.defaultLocale = 'fr_FR';
  initializeDateFormatting('fr_FR', null);
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ThemeMode.light;

    return MaterialApp(
      title: 'Foréclair',
      themeMode: themeMode,
      locale: Locale('fr', 'FR'),
      theme: ThemeData(
        colorScheme: snsmLightColorScheme,
        useMaterial3: true,
        textTheme: GoogleFonts.fredokaTextTheme(),
        appBarTheme: AppBarTheme(backgroundColor: SNSMColors.bleuMarin, foregroundColor: SNSMColors.blanc, elevation: 2),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: SNSMColors.rouge, foregroundColor: SNSMColors.blanc, elevation: 3),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: SNSMColors.orange,
          foregroundColor: SNSMColors.blanc,
        ),
      ),
      darkTheme: ThemeData(colorScheme: snsmDarkColorScheme, useMaterial3: true, fontFamily: 'Roboto'),
      home: const LoginGateway(),
      debugShowCheckedModeBanner: false,
    );
  }
}
