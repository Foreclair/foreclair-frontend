import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/assets/fonts/text_utils.dart';
import 'package:foreclair/src/data/dao/user_dao.dart';
import 'package:foreclair/src/data/models/logbook/event_type_dto.dart';
import 'package:foreclair/src/data/services/app/logbook/event_type_service.dart';
import 'package:foreclair/src/ui/components/layouts/topography_background.dart';
import 'package:foreclair/src/ui/pages/logbook/main/logbook_timeline.dart';
import 'package:foreclair/utils/units/size_utils.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/logs/logger_utils.dart';
import '../../../components/animations/route/wave_page_route.dart';
import '../action/logbook_action_page.dart';

class LogBookPage extends StatefulWidget {
  const LogBookPage({super.key});

  @override
  State<LogBookPage> createState() => _LogBookPageState();
}

class _LogBookPageState extends State<LogBookPage> {
  late final String formattedDate;
  late final Future<List<EventTypeDto>> _futureEvents;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    formattedDate = DateFormat("dd/MM/yyyy").format(now);

    _futureEvents = _fetchEvents();
  }

  Future<List<EventTypeDto>> _fetchEvents() async {
    try {
      final response = await EventTypeService.instance.getDailyEvents(UserDao.instance.currentUser!.station);
      return (response.data as List).map((e) => EventTypeDto.fromJson(e)).toList();
    } catch (error) {
      logger.e("Failed to fetch events: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: TopographyBackground(
              lineColorFilter: const ColorFilter.mode(Color(0x52A1A1A1), BlendMode.srcIn),
              backgroundColors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withAlpha(230)],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => {Navigator.of(context).pop()},
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(CupertinoIcons.back, color: Theme.of(context).colorScheme.onPrimaryContainer),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              CupertinoIcons.ellipsis_vertical,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.height(2)),
                    Text(
                      "Main courante du $formattedDate",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              // 🔑 FutureBuilder for events
              Expanded(
                child: FutureBuilder<List<EventTypeDto>>(
                  future: _futureEvents,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Failed to load events", style: Theme.of(context).textTheme.bodyLarge));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No events yet"));
                    }

                    final events = snapshot.data!;
                    return LogbookTimeline(events: events);
                  },
                ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(WavePageRoute(page: const LogBookActionPage()));
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(CupertinoIcons.add, color: Theme.of(context).colorScheme.onSecondary),
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
}
