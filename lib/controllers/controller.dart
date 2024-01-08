import 'package:flutter/material.dart';

import '../constants/answer_stages.dart';
import '../models/tile_model.dart';

class Controller extends ChangeNotifier {
  String correctWord = '';
  int currentTile = 0, currentRow = 0;
  List<TileModel> tilesEntered = [];

  //?? whenever a key is tapped ->
  setKeyTapped({required String value}) {
    if (value == 'ENTER') {
      if (currentTile == 5 * (currentRow + 1)) {
        checkWord();
      }
    } else if (value == 'BACK') {
      if (currentTile > 5 * (currentRow + 1) - 5) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      if (currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(
          TileModel(
            letter: value,
            answerStage: AnswerStage.notAnswered,
          ),
        );
        currentTile++;
      }
    }
    notifyListeners();
  }

  //?? set correct word ->
  setCorrectWord({required String word}) => correctWord = word;

  //?? check word ->
  checkWord() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = '';

    for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      guessed.add(tilesEntered[i].letter);
    }
    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (guessedWord == correctWord) {
      print('Correct');
    } else {
      for (int i = 0; i < 5; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          // tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          // keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
          print('Letter guessed at ${guessedWord[i]}');
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < 5; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * 5)].letter) {
            print('contains at ${remainingCorrect[i]}');
          }
        }
      }
    }
    currentRow++;
  }
}
