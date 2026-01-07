// This class can be replaced by one string, but in the future Player will have more information.
class Player {
  final String name;
  final int id;

  const Player({required this.name, required this.id});

  @override
  String toString() {
    return name;
  }
}