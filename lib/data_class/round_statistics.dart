import 'package:lora_app/data_class/players.dart';
import 'package:lora_app/data_class/points.dart';

import 'game_type.dart';

class RoundStatistics {
  final GameType id;
  final Players players;
  final Points points;

  const RoundStatistics({required this.id, required this.points, required this.players});

  @override
  String toString() {
    return List.generate(4, (i) => "${players[i]}: ${points[i]}").toString();
  }
}