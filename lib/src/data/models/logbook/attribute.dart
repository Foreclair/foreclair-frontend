import 'package:foreclair/src/data/models/logbook/event_type_attribute.dart';

class Attribute {
  final String key;
  final String title;
  final EventTypeAttribute type;

  Attribute({required this.key, required this.title, required this.type});
}
