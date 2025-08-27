import 'package:foreclair/src/data/models/logbook/event_type_field.dart';

class EventAttribute {
  final String key;
  final String title;
  final EventTypeField type;

  EventAttribute({required this.key, required this.title, required this.type});
}
