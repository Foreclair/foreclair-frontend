import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/meteo/tide/tide_model.dart';
import 'package:foreclair/src/ui/components/indicator/maree_indicator.dart';
import 'package:foreclair/utils/units/size_utils.dart';

class MeteoCard extends StatelessWidget {
  final VoidCallback? onTap;

  const MeteoCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateTime now = DateTime.now();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: theme.colorScheme.primaryContainer,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 4,
        child: SizedBox(
          height: context.height(25),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 50),
                  child: TideCurve(
                    tides: [
                      TideModel(time: now.copyWith(hour: 4, minute: 45), coefficient: 95, isHighTide: false),
                      TideModel(time: now.copyWith(hour: 10, minute: 5), coefficient: 95, isHighTide: true),
                      TideModel(time: now.copyWith(hour: 17, minute: 0), coefficient: 95, isHighTide: false),
                      TideModel(time: now.copyWith(hour: 22, minute: 21), coefficient: 95, isHighTide: true),
                    ],
                    currentTime: now,
                    curveColor: Colors.white.withAlpha(50),
                    gradientStartColor: theme.colorScheme.onSurfaceVariant.withAlpha(30),
                    gradientEndColor: theme.colorScheme.onSurfaceVariant.withAlpha(10),
                    tideHeight: context.height(10),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTopStat(context, "26°C", "air", CupertinoIcons.thermometer_sun),
                        _buildTopStat(context, "18°C", "eau", CupertinoIcons.drop),
                      ],
                    ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBottomStat(context, "17 km/h", "Vent", CupertinoIcons.wind),
                        _buildBottomStat(context, "N/O", "Direction", CupertinoIcons.arrow_up_left),
                        _buildBottomStat(context, "5", "UV", CupertinoIcons.sun_min_fill),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopStat(BuildContext context, String value, String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer, size: 35),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(150)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomStat(BuildContext context, String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer, size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(150)),
        ),
      ],
    );
  }
}
