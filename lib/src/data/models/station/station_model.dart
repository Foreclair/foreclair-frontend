class Station {
  final String id;
  final double location;
  final String name;

  Station({required this.id, required this.location, required this.name});

  static fromJson(station) {
    return Station(id: station['id'] ?? '0', location: station['location']?.toDouble() ?? 0.0, name: station['name'] ?? '');
  }
}
