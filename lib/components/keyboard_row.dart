import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/controllers/controller.dart';

import '../constants/answer_stages.dart';
import '../constants/colors.dart';
import '../data/key_maps.dart';

class KeyboardRow extends StatelessWidget {
  final int min;
  final int max;

  const KeyboardRow({
    super.key,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<Controller>(
      builder: (_, notifier, __) {
        int index = 0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: keysMap.entries.map(
            (e) {
              index++;
              if (index >= min && index <= max) {
                Color color = Theme.of(context).primaryColorLight;
                Color keyColor = Colors.white;
                if (e.value == AnswerStage.correct) {
                  color = correctGreen;
                } else if (e.value == AnswerStage.contains) {
                  color = containsYellow;
                } else if (e.value == AnswerStage.incorrect) {
                  color = Theme.of(context).primaryColorDark;
                } else {
                  keyColor = Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black;
                }
                return Padding(
                  padding: EdgeInsets.all(size.width * 0.006),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: SizedBox(
                      width: e.key == 'ENTER' || e.key == 'BACK'
                          ? size.width * 0.13
                          : size.width * 0.085,
                      height: size.height * 0.085,
                      child: Material(
                        color: color,
                        child: InkWell(
                          onTap: () {
                            Provider.of<Controller>(context, listen: false)
                                .setKeyTapped(value: e.key);
                          },
                          child: Center(
                            child: e.key == 'BACK'
                                ? const Icon(Icons.backspace_outlined)
                                : Text(
                                    e.key,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: keyColor,
                                        ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ).toList(),
        );
      },
    );
  }
}
