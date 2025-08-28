import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:foreclair/src/data/models/logbook/event_type_dto.dart';
import 'package:foreclair/src/data/models/logbook/event_types.dart';
import 'package:foreclair/src/data/models/station/station_model.dart';
import 'package:foreclair/src/data/services/http/api_service.dart';
import 'package:intl/intl.dart';

class EventTypeService {
  static final EventTypeService _instance = EventTypeService._privateConstructor();

  static EventTypeService get instance => _instance;

  EventTypeService._privateConstructor();

  void sendEventType(EventTypeDto eventType) {
    ApiService.instance.post(path: '/events/new', data: jsonEncode(eventType.toJson()));
  }

  Future<Response> getDailyEvents(Station station) {
    return ApiService.instance.get(
      path: '/events/daily',
      queryParameters: {'day': DateFormat("yyyy-MM-dd").format(DateTime.now()), 'station': station.id},
    );
  }

  EventType getEventTypeByKey(String key) {
    return EventType.values.firstWhere((eventType) => eventType.key == key);
  }
}
