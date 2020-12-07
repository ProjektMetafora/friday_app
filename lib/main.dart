import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:friday_app/screens/login/login.screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friday App',
      theme: ThemeData(
        textTheme: GoogleFonts.ibmPlexMonoTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
