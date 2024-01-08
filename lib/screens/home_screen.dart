import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/controllers/controller.dart';

import '../components/grid.dart';
import '../components/keyboard_row.dart';
import '../constants/words.dart';

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
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 7,
            child: Grid(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: const Column(
                children: [
                  KeyboardRow(min: 1, max: 10),
                  KeyboardRow(min: 11, max: 19),
                  KeyboardRow(min: 20, max: 29),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
