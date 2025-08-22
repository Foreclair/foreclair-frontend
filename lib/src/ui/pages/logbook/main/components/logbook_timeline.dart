import 'package:flutter/material.dart';

class LogbookTimeline extends StatefulWidget {
  const LogbookTimeline({super.key});

  @override
  State<LogbookTimeline> createState() => _LogbookTimelineState();
}

class _LogbookTimelineState extends State<LogbookTimeline> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 20), child: Text("popo")),
    );
  }
}
