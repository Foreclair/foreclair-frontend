import 'package:foreclair/src/data/models/station/station_model.dart';

class Sector {
  final String id;
  final double location;
  final String name;
  final List<Station> stations;

  Sector({required this.id, required this.location, required this.name, required this.stations});

  static fromJson(data) {
    return Sector(
      id: data['id'] ?? '0',
      location: data['location']?.toDouble() ?? 0.0,
      name: data['name'] ?? '',
      stations:
          (data['stations'] as List<dynamic>?)
              ?.map((s) {
                if (s is Map) {
                  return Station.fromJson(s);
                } else {
                  return Station(id: s.toString(), location: 0.0, name: '');
                }
              })
              .toList()
              .cast<Station>() ??
          [],
    );
  }
}
