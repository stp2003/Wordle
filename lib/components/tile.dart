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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _borderColor = Theme.of(context).primaryColorDark;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        String text = '';
        Color fontColor = Colors.white;
        if (widget.index < notifier.tilesEntered.length) {
          text = notifier.tilesEntered[widget.index].letter;
          _answerStage = notifier.tilesEntered[widget.index].answerStage;
          _backgroundColor = Theme.of(context).primaryColorLight;
          if (_answerStage == AnswerStage.correct) {
            _backgroundColor = correctGreen;
            _borderColor = Colors.transparent;
          } else if (_answerStage == AnswerStage.contains) {
            _backgroundColor = containsYellow;
            _borderColor = Colors.transparent;
          } else if (_answerStage == AnswerStage.incorrect) {
            _backgroundColor = Theme.of(context).primaryColorDark;
            _borderColor = Colors.transparent;
          } else {
            fontColor =
                Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
            _backgroundColor = Colors.transparent;
          }
          return Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
              border: Border.all(
                color: _borderColor,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  text,
                  style: const TextStyle().copyWith(color: fontColor),
                ),
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
              border: Border.all(
                color: _borderColor,
              ),
            ),
          );
        }
      },
    );
  }
}
