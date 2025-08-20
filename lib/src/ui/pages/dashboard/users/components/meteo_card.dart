import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/meteo/tide/tide_model.dart';
import 'package:foreclair/src/ui/components/indicator/maree_indicator.dart';
import 'package:foreclair/utils/units/size_utils.dart';

import '../../../../../../assets/fonts/text_utils.dart';

class MeteoCard extends StatelessWidget {
  const MeteoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateTime now = DateTime.now();

    return GestureDetector(
      onTap: () {},
      child: Card(
        color: theme.colorScheme.primaryContainer,
        elevation: 8.0,
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(top: 50, bottom: 30),
              child: TideCurve(
                tides: [
                  TideModel(time: now.copyWith(hour: 4, minute: 45), coefficient: 95, isHighTide: false),
                  TideModel(time: now.copyWith(hour: 10, minute: 5), coefficient: 95, isHighTide: true),
                  TideModel(time: now.copyWith(hour: 17, minute: 0), coefficient: 95, isHighTide: false),
                  TideModel(time: now.copyWith(hour: 22, minute: 21), coefficient: 95, isHighTide: true),
                ],
                currentTime: now,
                curveColor: theme.colorScheme.outlineVariant.withAlpha(100),
                gradientStartColor: theme.colorScheme.onSurfaceVariant.withAlpha(30),
                gradientEndColor: theme.colorScheme.surface.withAlpha(10),
                height: context.height(10),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(context, "Température", "18°C"),
                      _buildStatItem(context, "Vent", "15 km/h"),
                      _buildStatItem(context, "Humidité", "60%"),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
