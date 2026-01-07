enum GameType {
  max("Max"),
  min("Min"),
  kralj("Kralj \u2665"),
  sva("Sva \u2665\u2665"),
  zandar("Žandar \u2663"),
  dame("Dame"),
  lora("Lora"),
  none("None");

  final String name;
  const GameType(this.name);

  static final List<GameType> gameTypes = [
    GameType.max, GameType.min, GameType.kralj, GameType.sva, GameType.zandar, GameType.dame, GameType.lora
  ];

  @override
  String toString() {
    return name;
  }
}