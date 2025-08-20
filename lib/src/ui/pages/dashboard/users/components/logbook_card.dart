import 'package:flutter/material.dart';
import 'package:foreclair/assets/fonts/text_utils.dart';
import 'package:foreclair/utils/units/size_utils.dart';

class LogbookCard extends StatelessWidget {
  final VoidCallback? onTap;

  const LogbookCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = DateTime.now().toLocal().toString().split(' ')[0].split('-').reversed.join('/');

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8.0,
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    child: Text(
                      'Ouvrir',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Text(
                    'Main courante',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Text('Du $date', style: bodySmall, textAlign: TextAlign.center),
                ],
              ),

              SizedBox(height: context.height(3)),
              Divider(thickness: 1, color: theme.colorScheme.outline.withAlpha(50)),
              SizedBox(height: context.height(1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(context, 'Interventions', '13'),
                  _buildStatItem(context, 'Soins', '7'),
                  _buildStatItem(context, 'Préventions', '23'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String labelc, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 4.0),
        Text(labelc, style: label, textAlign: TextAlign.center),
      ],
    );
  }
}
