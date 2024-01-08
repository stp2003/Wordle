import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/controllers/controller.dart';

import '../constants/answer_stages.dart';

class Tile extends StatefulWidget {
  final int index;

  const Tile({
    super.key,
    required this.index,
  });

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  Color _backgroundColor = Colors.transparent,
      _borderColor = Colors.transparent;
  late AnswerStage _answerStage;

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        String text = '';
        if (widget.index < notifier.tilesEntered.length) {
          text = notifier.tilesEntered[widget.index].letter;
          _answerStage = notifier.tilesEntered[widget.index].answerStage;
          if (_answerStage == AnswerStage.correct) {
            _backgroundColor = correctGreen;
          } else if (_answerStage == AnswerStage.contains) {
            _backgroundColor = containsYellow;
          }
          return Container(
            color: _backgroundColor,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(text),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
