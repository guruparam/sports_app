import 'package:flutter/material.dart';
import 'package:sports_app/pages/auth_page.dart';
import 'package:sports_app/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SPORTS APP',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
