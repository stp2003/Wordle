import 'package:flutter/material.dart';

import '../components/grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
