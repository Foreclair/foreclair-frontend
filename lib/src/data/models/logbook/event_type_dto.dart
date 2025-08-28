class EventTypeDto {
  final String key;
  final String station;
  final String author;
  final DateTime date;
  final Map<String, String> attributes;

  EventTypeDto(this.key, this.station, this.author, this.date, this.attributes);

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'station': station,
      'author': author,
      'date': date.toIso8601String(),
      'attributes': attributes,
    };
  }
}