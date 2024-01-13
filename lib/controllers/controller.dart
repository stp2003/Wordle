import 'package:flutter/material.dart';

import '../constants/answer_stages.dart';
import '../data/key_maps.dart';
import '../functions/calculate_stats.dart';
import '../functions/claculate_charts_stats.dart';
import '../models/tile_model.dart';

class Controller extends ChangeNotifier {
  String correctWord = '';
  bool checkLine = false,
      isBackOrEnter = false,
      gameWon = false,
      gameCompleted = false,
      notEnoughLetters = false;
  int currentTile = 0, currentRow = 0;
  List<TileModel> tilesEntered = [];

  //?? whenever a key is tapped ->
  setKeyTapped({required String value}) {
    if (value == 'ENTER') {
      if (currentTile == 5 * (currentRow + 1)) {
        isBackOrEnter = true;
        checkWord();
      } else {
        notEnoughLetters = true;
      }
    } else if (value == 'BACK') {
      notEnoughLetters = false;
      if (currentTile > 5 * (currentRow + 1) - 5) {
        currentTile--;
        tilesEntered.removeLast();
        isBackOrEnter = true;
      }
    } else {
      notEnoughLetters = false;
      if (currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(
          TileModel(
            letter: value,
            answerStage: AnswerStage.notAnswered,
          ),
        );
        currentTile++;
        isBackOrEnter = false;
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
      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
        gameCompleted = true;
      }
    } else {
      for (int i = 0; i < 5; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < 5; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * 5)].letter) {
            if (tilesEntered[j + (currentRow * 5)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * 5)].answerStage =
                  AnswerStage.contains;
            }
            final resultKey = keysMap.entries.where((element) =>
                element.key == tilesEntered[j + (currentRow * 5)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keysMap.update(
                resultKey.single.key,
                (value) => AnswerStage.contains,
              );
            }
          }
        }
      }
      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;

          final results = keysMap.entries.where(
            (element) => element.key == tilesEntered[i].letter,
          );
          if (results.single.value == AnswerStage.notAnswered) {
            keysMap.update(
              tilesEntered[i].letter,
              (value) => AnswerStage.incorrect,
            );
          }
        }
      }
    }
    currentRow++;
    checkLine = true;

    if (currentRow == 6) {
      gameCompleted = true;
    }

    if (gameCompleted) {
      calculateStats(gameWon: gameWon);
      if (gameWon) {
        setChartStats(currentRow: currentRow);
      }
    }

    notifyListeners();
  }
}
