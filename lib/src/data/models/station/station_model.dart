class Station {
  final String id;
  final String name;
  final double longitude;
  final double latitude;


  Station(this.id, this.name, this.longitude, this.latitude);

  factory Station.fromJson(station) {
    return Station(station['id'] ?? '0', station['name'] ?? '', station['longitude']?.toDouble() ?? 0.0, station['latitude']?.toDouble() ?? 0.0);
  }
}
