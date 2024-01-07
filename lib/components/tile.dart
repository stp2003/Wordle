import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/controllers/controller.dart';

class Tile extends StatelessWidget {
  final int index;

  const Tile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        String text = '';
        if (index < notifier.tilesEntered.length) {
          text = notifier.tilesEntered[index].letter;
          return Center(
            child: Text(text),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
