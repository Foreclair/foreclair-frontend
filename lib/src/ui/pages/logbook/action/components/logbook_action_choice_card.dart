import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/logbook/event_types.dart';

class LogbookActionChoiceCard extends StatelessWidget {
  final VoidCallback callback;
  final EventType event;

  const LogbookActionChoiceCard({super.key, required this.callback, required this.event});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: callback,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Theme.of(context).colorScheme.surface,
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          event.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.subtitle,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -24,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: event.color,
                  child: Icon(event.icon, size: 28, color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
