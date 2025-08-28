import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/logbook/event_type_dto.dart';
import 'package:foreclair/src/data/models/logbook/event_types.dart';
import 'package:foreclair/src/data/services/app/logbook/event_type_service.dart';
import 'package:intl/intl.dart';

class LogbookTimeline extends StatefulWidget {
  final List<EventTypeDto> events;

  const LogbookTimeline({super.key, required this.events});

  @override
  State<LogbookTimeline> createState() => _LogbookTimelineState();
}

class _LogbookTimelineState extends State<LogbookTimeline> {
  final ScrollController _scrollController = ScrollController();
  final List<EventType> _eventTypes = [];

  @override
  void didUpdateWidget(covariant LogbookTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.events.length != oldWidget.events.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    }
  }

  @override
  void initState() {
    for (var value in widget.events) {
      _eventTypes.add(EventTypeService.instance.getEventTypeByKey(value.key));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sortedEvents = [...widget.events]..sort((a, b) => a.date.compareTo(b.date));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: sortedEvents.length,
          itemBuilder: (context, index) {
            return _buildTimelineRow(context, sortedEvents[index]);
          },
        ),
      ),
    );
  }

  Widget _buildTimelineRow(BuildContext context, EventTypeDto event) {
    final timeFormatted = DateFormat.Hm().format(event.date);
    final eventType = _eventTypes.firstWhere(
      (et) => et.key == event.key,
      orElse: () => EventType(
        key: 'unknown',
        title: 'Inconnu',
        subtitle: 'Type d\'événement inconnu',
        icon: Icons.help_outline,
        color: Colors.grey,
        attributes: [],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            child: Text(timeFormatted, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.right),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  children: [
                    Icon(eventType.icon, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(child: Text(eventType.title, style: Theme.of(context).textTheme.bodyLarge)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
