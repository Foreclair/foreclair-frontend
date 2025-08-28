import 'package:foreclair/src/data/models/logbook/event_types.dart';

class Event {
  final String title;
  final DateTime start;
  final DateTime? end;
  final String description;
  final EventType type;

  Event({required this.title, required this.start, this.end, required this.description, required this.type});

  bool get isInstant => end == null || end == start;
}
