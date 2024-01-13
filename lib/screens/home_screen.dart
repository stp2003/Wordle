import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/stats_box.dart';
import 'package:wordle/controllers/controller.dart';
import 'package:wordle/screens/settings.dart';

import '../components/grid.dart';
import '../components/keyboard_row.dart';
import '../constants/words.dart';
import '../functions/run_quick_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _word;

  @override
  void initState() {
    final res = Random().nextInt(words.length);
    _word = words[res];
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<Controller>(context, listen: false)
            .setCorrectWord(word: _word);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        centerTitle: true,
        elevation: 5.0,
        actions: [
          Consumer<Controller>(
            builder: (_, notifier, __) {
              if (notifier.gameCompleted) {
                if (notifier.gameWon) {
                  if (notifier.currentRow == 6) {
                    runQuickBox(context: context, message: 'Phew!');
                  } else {
                    runQuickBox(context: context, message: 'Splendid!');
                  }
                } else {
                  runQuickBox(context: context, message: notifier.correctWord);
                }
                Future.delayed(
                  const Duration(milliseconds: 4000),
                  () {
                    if (mounted) {
                      showDialog(
                        context: context,
                        builder: (_) => const StatsBox(),
                      );
                    }
                  },
                );
              }
              return IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const StatsBox(),
                  );
                },
                icon: const Icon(Icons.bar_chart),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const Column(
        children: [
          Divider(thickness: 7, height: 1.0),
          Expanded(
            flex: 7,
            child: Grid(),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                KeyboardRow(min: 1, max: 10),
                KeyboardRow(min: 11, max: 19),
                KeyboardRow(min: 20, max: 29),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
