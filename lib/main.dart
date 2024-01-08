import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/controllers/controller.dart';
import 'package:wordle/screens/home_screen.dart';
import 'package:wordle/themes/theme.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Controller()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wordle',
      theme: darkTheme,
      home: const HomeScreen(),
    );
  }
}
