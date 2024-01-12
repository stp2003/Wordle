import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/controllers/controller.dart';
import 'package:wordle/controllers/theme_provider.dart';
import 'package:wordle/screens/home_screen.dart';
import 'package:wordle/themes/theme.dart';
import 'package:wordle/themes/theme_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: FutureBuilder(
        initialData: false,
        future: ThemePreferences.getTheme(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setTheme(turnOn: snapshot.data as bool);
              },
            );
          }
          return Consumer<ThemeProvider>(
            builder: (_, notifier, __) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Wordle',
                theme: notifier.isDark ? darkTheme : lightTheme,
                home: const HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
