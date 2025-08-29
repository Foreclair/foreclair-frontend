import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/logbook/event_type_dto.dart';
import 'package:foreclair/src/data/models/logbook/event_types.dart';
import 'package:foreclair/src/data/services/app/logbook/event_type_service.dart';
import 'package:foreclair/utils/logs/logger_utils.dart';
import 'package:intl/intl.dart';

class LogbookTimeline extends StatefulWidget {
  final List<EventTypeDto> events;

  const LogbookTimeline({super.key, required this.events});

  @override
  State<LogbookTimeline> createState() => _LogbookTimelineState();
}

class _LogbookTimelineState extends State<LogbookTimeline> {
  final ScrollController _scrollController = ScrollController();
  int? _selectedIndex;

  List<EventType> get _eventTypes => widget.events.map((e) => EventTypeService.instance.getEventTypeByKey(e.key)).toList();

  @override
  void didUpdateWidget(covariant LogbookTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.events.length != oldWidget.events.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          final event = widget.events[index];
          final eventType = _eventTypes[index];
          final isSelected = _selectedIndex == index;

          return _TimelineRow(
            event: event,
            eventType: eventType,
            isSelected: isSelected,
            onTap: () {
              logger.d("Tapped on event: ${eventType.title}");
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final EventTypeDto event;
  final EventType eventType;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimelineRow({required this.event, required this.eventType, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final timeFormatted = DateFormat.Hm().format(event.date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Time
          SizedBox(
            width: 60,
            child: Text(
              timeFormatted,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.right,
            ),
          ),

          const SizedBox(width: 12),

          // Event Card
          Expanded(
            child: Card(
              color: isSelected ? eventType.color.withAlpha(30) : Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: isSelected
                    ? BorderSide(color: eventType.color, width: 1.5)
                    : BorderSide(color: Theme.of(context).colorScheme.outline, width: .5),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: eventType.color.withAlpha(40),
                        child: Icon(eventType.icon, color: eventType.color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          eventType.title,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? eventType.color : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
