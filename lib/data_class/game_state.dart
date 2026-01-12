import 'package:lora_app/data_class/game_statistics.dart';
import 'package:lora_app/data_class/players.dart';
import 'package:lora_app/data_class/points.dart';
import 'package:lora_app/data_class/round_statistics.dart';

import 'game_type.dart';

class GameState {
  final Players players;
  final GameStatistics stats;
  final int gameCount, totalRounds, playerCount;
  int currentPlayer = 0, currentRound = 1;
  GameType game = GameType.none;
  bool showResults = false, _phase = true;
  String errorMessage = "";

  GameState({required this.players, this.gameCount = 7})
    : playerCount = players.length, totalRounds = gameCount * players.length, stats = GameStatistics(players: players);

  bool finishRound(Points points) {
    if (!points.checkGameRulesApply(game)) {
      errorMessage = "Error: points not given properly";
      return false;
    }
    stats.addRoundStatistics(
        RoundStatistics(id: game, points: points, players: players)
    );
    game = GameType.none;
    currentPlayer = (currentPlayer + 1) % 4;
    currentRound += 1;
    changePhase();
    return true;
  }

  bool isGameFinished() {
    return currentRound > totalRounds;
  }

  void changePhase() {
    _phase = !_phase;
    errorMessage = "";
  }

  bool getPhase() {
    return _phase;
  }
}