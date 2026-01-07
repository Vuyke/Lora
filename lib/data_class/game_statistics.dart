import 'package:lora_app/data_class/player.dart';
import 'package:lora_app/data_class/players.dart';
import 'package:lora_app/data_class/points.dart';
import 'package:lora_app/data_class/round_statistics.dart';

class GameStatistics {
  final List<RoundStatistics> roundStatisticsList = [];
  final Points totalPoints = Points.empty();
  final Players players;

  GameStatistics({
    required this.players
  });

  GameStatistics.fromNames({
    required List<String> playerNames
  }) : players = Players(names: playerNames);

  void addRoundStatistics(RoundStatistics roundStatistics) {
    roundStatisticsList.add(roundStatistics);
    totalPoints.add(roundStatistics.points);
  }

  List<MapEntry<Player, int>> playerResults() {
    return List<MapEntry<Player, int>>.generate(4,
      (index) => MapEntry(players[index], totalPoints[index])
    );
  }

  @override
  String toString() {
    return roundStatisticsList.join("\n");
  }
}
