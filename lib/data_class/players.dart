import 'package:lora_app/data_class/player.dart';

class Players {
  final List<Player> _players = [];
  final int length = 4;

  Players({
    required List<String> names
  }) {
    if(names.length != 4 && names.isNotEmpty) {
      throw ArgumentError('List must contain exactly 4 names.');
    }
    for(int i = 0; i < 4; i++) {
      String tmp = names.length == 4 ? names[i] : (i + 1).toString();
      _players.add(Player(name: tmp, id: i));
    }
  }

  Player operator [](int index) => _players[index];

  @override
  String toString() {
    return _players.toString();
  }
}
