class Event {
  final String title;
  final DateTime start;
  final DateTime? end;
  final String description;
  final String type;

  Event({required this.title, required this.start, this.end, required this.description, required this.type});

  bool get isInstant => end == null || end == start;
}
