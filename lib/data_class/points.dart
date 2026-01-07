import 'package:lora_app/data_class/game_type.dart';

class Points {
  final List<int> _points;

  Points({
    required int x1,
    required int x2,
    required int x3,
    required int x4
  }) : _points = [x1, x2, x3, x4];

  Points.empty() : _points = [0, 0, 0, 0];

  int operator [](int index) => _points[index];

  void operator []=(int index, int value) {
    _points[index] = value;
  }

  void add(Points points) {
    for(int i = 0; i < 4; i++) {
      _points[i] += points[i];
    }
  }

  void sort() {
    _points.sort((a, b) => a - b);
  }

  bool checkGameRulesApply(GameType selectedGame) {
    int sum = _points.reduce((a, b) => a + b);
    List<int> tmpPoints = List<int>.of(_points);
    tmpPoints.sort();
    switch(selectedGame) {
      case GameType.max:
        return _negative8(tmpPoints, sum);
      case GameType.min:
        return _positive8(tmpPoints, sum);
      case GameType.kralj:
        return _positive8(tmpPoints, sum) && _allDivisibleBy(tmpPoints, 4);
      case GameType.sva:
        return (_positive8(tmpPoints, sum) && tmpPoints[3] < 8) || (_negative8(tmpPoints, sum) && tmpPoints[0] == -8);
      case GameType.zandar:
        return _positive8(tmpPoints, sum) && tmpPoints[3] == 8;
      case GameType.dame:
        return _positive8(tmpPoints, sum) && _allDivisibleBy(tmpPoints, 2);
      case GameType.lora:
        return tmpPoints[0] == -8 && tmpPoints[1] > 0 && tmpPoints[3] <= 8;
      default:
        return true;
    }
  }

  bool _allDivisibleBy(List<int> newPoints, int div) {
    return newPoints.map((x) => x % div == 0).reduce((x, y) => x && y);
  }

  bool _positive8(List<int> newPoints, int sum) {
    return sum == 8 && newPoints[0] >= 0;
  }

  bool _negative8(List<int> newPoints, int sum) {
    return sum == -8 && newPoints[3] <= 0;
  }

  @override
  String toString() {
    return _points.toString();
  }
}