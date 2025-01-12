import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:jarvis/gemini_home.dart';
import 'package:jarvis/home_page.dart';
import 'package:jarvis/secrets.dart';

void main() {
  Gemini.init(apiKey: GEMINI_API_KEY);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jarvis',
        theme: ThemeData.light(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(color: Colors.white)),
        home: const HomePage());
  }
}
