import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/animations/bounce.dart';
import 'package:wordle/components/tile.dart';
import 'package:wordle/controllers/controller.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 30,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return Consumer<Controller>(
          builder: (_, notifier, __) {
            bool animate = false;
            if (index == notifier.currentTile - 1 && !notifier.isBackOrEnter) {
              animate = true;
            }
            return Bounce(
              animate: animate,
              child: Tile(index: index),
            );
          },
        );
      },
    );
  }
}
