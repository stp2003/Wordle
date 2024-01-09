import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/animations/bounce.dart';
import 'package:wordle/animations/dance.dart';
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
            bool animateDance = false;
            int danceDelay = 1600;
            if (index == notifier.currentTile - 1 && !notifier.isBackOrEnter) {
              animate = true;
            }
            if (notifier.gameWon) {
              for (int i = notifier.tilesEntered.length - 5;
                  i < notifier.tilesEntered.length;
                  i++) {
                if (index == i) {
                  animateDance = true;
                  danceDelay += 150 * (i - ((notifier.currentRow - 1) * 5));
                }
              }
            }
            return Dance(
              delay: danceDelay,
              animate: animateDance,
              child: Bounce(
                animate: animate,
                child: Tile(index: index),
              ),
            );
          },
        );
      },
    );
  }
}
