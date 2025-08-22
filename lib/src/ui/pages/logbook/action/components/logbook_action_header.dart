import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogbookActionHeader extends StatelessWidget {
  const LogbookActionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(CupertinoIcons.back, color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Nouvelle Action',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            'Ajouter une nouvelle action à la main courante',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
