class EventTypeDto {
  final String key;
  final String station;
  final String author;
  final Map<String, String> attributes;

  EventTypeDto(this.key, this.station, this.author, this.attributes);

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'station': station,
      'author': author,
      'attributes': attributes,
    };
  }
}