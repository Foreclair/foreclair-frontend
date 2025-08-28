class EventTypeDto {
  final String key;
  final String station;
  final String author;
  final DateTime date;
  final Map<String, String> attributes;

  EventTypeDto(this.key, this.station, this.author, this.date, this.attributes);

  factory EventTypeDto.fromJson(Map<String, dynamic> json) {
    return EventTypeDto(
      json['key'] as String,
      json['station'] as String,
      json['author'] as String,
      DateTime.parse(json['date'] as String),
      Map<String, String>.from(json['attributes'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {'key': key, 'station': station, 'author': author, 'date': date.toIso8601String(), 'attributes': attributes};
  }
}
