import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/assets/fonts/text_utils.dart';
import 'package:foreclair/utils/units/size_utils.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/logbook/event_model.dart';
import '../../../components/animations/route/wave_page_route.dart';
import '../action/logbook_action_page.dart';

class LogBookPage extends StatefulWidget {
  const LogBookPage({super.key});

  @override
  State<LogBookPage> createState() => _LogBookPageState();
}

class _LogBookPageState extends State<LogBookPage> {
  late final String formattedDate;
  Event? selectedEvent;

  // Define a map to store the "lane" (horizontal offset) for each event to visualize overlaps
  final Map<Event, int> _eventLanes = {};
  final double _laneWidth = 25.0; // Width for each overlap lane, adjusted for better separation

  // Color mapping for different event types
  final Map<String, Color> eventColors = {
    'surveillance': Colors.blue,
    'intervention': Colors.red,
    'pause': Colors.orange,
    'closure': Colors.green,
    'default': Colors.grey,
  };

  // ⚠️ Exemple de données temporaires with event types
  final List<Event> events = [
    Event(
      title: "Début de la surveillance",
      start: DateTime(2025, 8, 18, 9, 0),
      description: "Observation de la plage commencée.",
      type: "surveillance", // Add type property to your Event model
    ),
    Event(
      title: "Intervention baignade",
      start: DateTime(2025, 8, 18, 10, 15),
      end: DateTime(2025, 8, 18, 11, 0),
      description: "Assistance à un nageur en difficulté.",
      type: "intervention",
    ),
    Event(
      title: "Intervention secourisme",
      start: DateTime(2025, 8, 18, 10, 45),
      end: DateTime(2025, 8, 18, 11, 30),
      description: "Formation de sécurité avec l'équipe.",
      type: "surveillance",
    ),
    Event(
      title: "Pause déjeuner",
      start: DateTime(2025, 8, 18, 12, 30),
      end: DateTime(2025, 8, 18, 13, 15),
      description: "Pause repas de l'équipe.",
      type: "pause",
    ),
    Event(
      title: "Contrôle équipements",
      start: DateTime(2025, 8, 18, 14, 0),
      end: DateTime(2025, 8, 18, 14, 30),
      description: "Vérification du matériel de sauvetage.",
      type: "surveillance",
    ),
    Event(
      title: "Clôture du poste",

      start: DateTime(2025, 8, 18, 18, 0),
      description: "Fin de la surveillance.",
      type: "closure",
    ),
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    formattedDate = DateFormat("dd/MM/yyyy").format(now);
    _calculateEventLanes(); // Calculate lanes on init
  }

  // A function to calculate overlapping lanes for events
  // This helps in horizontally offsetting event markers/lines to show concurrency.
  void _calculateEventLanes() {
    // Sort events by start time to process them chronologically
    events.sort((a, b) => a.start.compareTo(b.start));

    // List to keep track of active lanes and the time they become free
    // Each entry: { 'endTime': DateTime, 'laneIndex': int }
    List<Map<String, dynamic>> activeLanes = [];

    for (var event in events) {
      // Clean up expired lanes: remove lanes whose events have already ended
      activeLanes.removeWhere((lane) => lane['endTime'].isBefore(event.start));

      int assignedLane = 0;
      bool laneFound = false;

      // Sort active lanes by their end time to prioritize re-using earlier freed lanes
      activeLanes.sort((a, b) => a['endTime'].compareTo(b['endTime']));

      for (int i = 0; i < activeLanes.length; i++) {
        // If an active lane's event has finished before the current event starts, reuse this lane
        if (event.start.isAfter(activeLanes[i]['endTime'])) {
          assignedLane = activeLanes[i]['laneIndex'];
          // Update the end time for the reused lane with the current event's end time
          activeLanes[i]['endTime'] = event.end ?? event.start.add(const Duration(minutes: 1));
          laneFound = true;
          break;
        }
      }

      if (!laneFound) {
        // If no existing lane can be reused, assign a new lane
        if (activeLanes.isEmpty) {
          assignedLane = 0; // First event or no active lanes
        } else {
          // Find the maximum lane index currently in use and assign the next one
          assignedLane = activeLanes.map((lane) => lane['laneIndex'] as int).reduce(max) + 1;
        }
        activeLanes.add({'endTime': event.end ?? event.start.add(const Duration(minutes: 1)), 'laneIndex': assignedLane});
      }
      _eventLanes[event] = assignedLane;
    }
  }

  @override
  Widget build(BuildContext context) {
    events.sort((a, b) => a.start.compareTo(b.start));

    // Calculate max lane index to determine necessary width for timeline visualization
    final int maxLane = _eventLanes.values.isNotEmpty ? _eventLanes.values.reduce(max) : 0;
    // This width ensures enough space for all parallel lanes + padding
    final double totalTimelineVisualizationWidth = _laneWidth * (maxLane + 1) + 20;

    return Scaffold(
      appBar: AppBar(
        title: Text("Main courante du $formattedDate"),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
      ),

      /// Enhanced Body = Vertical Timeline + detail (Scrollable)
      body: Row(
        children: [
          /// Timeline (70% width) - Scrollable list of events
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                itemCount: events.length, // Iterate directly over events
                itemBuilder: (context, index) {
                  final event = events[index];
                  final int laneIndex = _eventLanes[event] ?? 0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // Consistent padding between event rows
                    child: IntrinsicHeight(
                      // Ensures row takes height of its tallest child
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children to fill height
                        children: [
                          // Left side: Time label and Event Timeline Visualization for this event
                          SizedBox(
                            width: context.width(12) + totalTimelineVisualizationWidth, // Dynamic width for timeline area
                            child: Stack(
                              clipBehavior: Clip.none, // Allows children to draw outside their bounds
                              children: [
                                // Main vertical timeline line for general flow
                                // This line runs through the entire timeline area
                                Positioned(
                                  left: context.width(12) / 2 - 1.5, // Center line relative to time label
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 3,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(1.5),
                                    ),
                                  ),
                                ),
                                // Time Label
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Text(
                                    _formatEventTime(event),
                                    style: bodySmallBold.copyWith(color: Colors.grey[600], fontSize: 14),
                                  ),
                                ),
                                // Event Timeline Bar (marker + duration line for THIS event)
                                // Positioned horizontally based on its assigned lane to show overlaps
                                _buildEventTimelineBar(event, laneIndex, context.width(12) / 2),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Right side: Compact Event Card (the "line with the title")
                          Expanded(child: _buildCompactEventCard(event, context)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// Right panel: details (30% width)
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(30),
                border: Border(left: BorderSide(color: Colors.grey[300]!, width: 1)),
              ),
              child: selectedEvent == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app, size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            "Sélectionnez un événement",
                            style: bodyMedium.copyWith(color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : _buildEventDetails(selectedEvent!, context),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(WavePageRoute(page: const LogBookActionPage()));
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(CupertinoIcons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsetsGeometry.directional(top: context.height(2)),
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.height(1), horizontal: context.width(2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFooterButton("Action 1"),
              _buildFooterButton("Action 2"),
              _buildFooterButton("Action 3"),
              _buildFooterButton("Action 4"),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build the event's timeline bar (marker + short duration line)
  Widget _buildEventTimelineBar(Event event, int laneIndex, double timeLabelCenterOffset) {
    final eventColor = eventColors[event.type] ?? eventColors['default']!;
    final double markerSize = 12.0;
    final double durationLineHeight = 30.0; // Short line for duration visualization

    // Calculate horizontal position for this event's lane
    final double xPosition = timeLabelCenterOffset + (laneIndex * _laneWidth);

    return Positioned(
      left: xPosition - markerSize / 2, // Center marker on its lane's x-position
      top: 0, // Position at the top of the event row
      child: Column(
        children: [
          // Event start marker (small circle)
          Container(
            width: markerSize,
            height: markerSize,
            decoration: BoxDecoration(
              color: eventColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [BoxShadow(color: eventColor.withAlpha(75), blurRadius: 4, offset: const Offset(0, 2))],
            ),
          ),
          // Short duration line (only if event has an end time)
          if (event.end != null)
            Container(
              width: 3, // Thin vertical line
              height: durationLineHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [eventColor, eventColor.withAlpha(140)],
                ),
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCompactEventCard(Event event, BuildContext context) {
    final eventColor = eventColors[event.type] ?? eventColors['default']!;
    final isSelected = selectedEvent == event;

    return GestureDetector(
      onTap: () {
        setState(() => selectedEvent = event);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // Height is implicitly handled by the ListView's padding and IntrinsicHeight of parent Row
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? eventColor.withAlpha(15) : eventColor.withAlpha(5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? eventColor : eventColor.withAlpha(30), width: isSelected ? 2 : 1),
          boxShadow: isSelected
              ? [BoxShadow(color: eventColor.withAlpha(20), blurRadius: 6, offset: const Offset(0, 2))]
              : null,
        ),
        child: Row(
          children: [
            // Event type indicator
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: eventColor, shape: BoxShape.circle),
            ),

            const SizedBox(width: 12),

            // Event title - flexible
            Expanded(
              flex: 3,
              child: Text(
                event.title,
                style: bodySmallBold.copyWith(color: isSelected ? eventColor.withAlpha(200) : Colors.grey[800], fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(width: 8),

            // Duration/Type icon
            Icon(event.end != null ? Icons.schedule : Icons.flash_on, size: 16, color: eventColor.withAlpha(170)),
          ],
        ),
      ),
    );
  }

  Widget _buildEventDetails(Event event, BuildContext context) {
    final eventColor = eventColors[event.type] ?? eventColors['default']!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: eventColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  event.title,
                  style: titleMedium.copyWith(fontWeight: FontWeight.bold, color: eventColor.withAlpha(220)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Time info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: eventColor.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: eventColor.withAlpha(50), width: 1),
            ),
            child: Row(
              children: [
                Icon(event.end != null ? Icons.schedule : Icons.access_time, size: 18, color: eventColor),
                const SizedBox(width: 8),
                Text(
                  _formatEventTime(event),
                  style: bodyMedium.copyWith(fontWeight: FontWeight.w500, color: eventColor.withAlpha(230)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Description
          Text(
            "Description",
            style: bodyMedium.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          Text(event.description, style: bodyMedium.copyWith(height: 1.5)),

          const SizedBox(height: 24),

          // Duration if applicable
          if (event.end != null) ...[
            Text(
              "Durée",
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              _calculateDuration(event),
              style: bodyMedium.copyWith(color: eventColor.withAlpha(180), fontWeight: FontWeight.w500),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFooterButton(String label) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: context.width(3), vertical: context.height(1)),
      ),
      onPressed: () {},
      child: Text(label, style: bodySmallBold),
    );
  }

  String _formatEventTime(Event event) {
    final start = DateFormat.Hm().format(event.start);
    final end = event.end != null ? DateFormat.Hm().format(event.end!) : null;
    return end != null ? "$start - $end" : start;
  }

  String _calculateDuration(Event event) {
    if (event.end == null) return "Instantané";

    final duration = event.end!.difference(event.start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return "${hours}h ${minutes}min";
    } else {
      return "${minutes}min";
    }
  }
}
