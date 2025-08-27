import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/logbook/event_attribute.dart';
import 'package:foreclair/src/ui/components/inputs/time_input_widget.dart';

typedef BiFunction<A> = Widget Function(EventAttribute attribute, A a);

class EventTypeField<T> {
  final BiFunction<FormFieldSetter<T>> builder;
  final String Function(dynamic data) toJson;

  const EventTypeField({required this.builder, required this.toJson});

  Widget buildField(EventAttribute attr, Map<String, dynamic> data) {
    return builder(attr, (newValue) => data[attr.key] = newValue);
  }
}

class EventTypeAttributes {
  static final clock = EventTypeField<TimeOfDay>(
    builder: (attribute, onSaved) => TimeInputFormField(attribute: attribute, onSaved: onSaved),
    toJson: (time) {
      final now = DateTime.now();
      final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
      return dateTime.toIso8601String();
    },
  );

  static final comment = EventTypeField<String>(
    builder: (attribute, onSaved) => TextFormField(
      decoration: InputDecoration(labelText: attribute.title),
      onSaved: onSaved,
    ),
    toJson: (data) => data,
  );
}
