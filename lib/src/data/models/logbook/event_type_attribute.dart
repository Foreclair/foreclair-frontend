import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/logbook/attribute.dart';
import 'package:foreclair/src/ui/components/inputs/time_input_widget.dart';

typedef BiFunction<A> = Widget Function(Attribute attribute, A a);

class EventTypeAttribute<T> {
  final BiFunction<FormFieldSetter<T>> builder;

  const EventTypeAttribute({required this.builder});

  Widget buildField(Attribute attr, Map<String, dynamic> data) {
    return builder(attr, (newValue) => data[attr.key] = newValue);
  }
}

class EventTypeAttributes {
  static final clock = EventTypeAttribute<TimeOfDay>(
    builder: (attribute, onSaved) => TimeInputFormField(attribute: attribute, onSaved: onSaved),
  );

  static final comment = EventTypeAttribute<String>(
    builder: (attribute, onSaved) => TextFormField(
      decoration: InputDecoration(labelText: attribute.title),
      onSaved: onSaved,
    ),
  );
}
