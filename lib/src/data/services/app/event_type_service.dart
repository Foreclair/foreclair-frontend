import 'dart:convert';

import 'package:foreclair/src/data/models/logbook/event_type_dto.dart';
import 'package:foreclair/src/data/services/http/api_service.dart';

class EventTypeService {
  static final EventTypeService _instance = EventTypeService._privateConstructor();

  static EventTypeService get instance => _instance;

  EventTypeService._privateConstructor();

  void sendEventType(EventTypeDto eventType) {
    ApiService.instance.post(path: '/event/new', data: jsonEncode(eventType.toJson()));
  }

}