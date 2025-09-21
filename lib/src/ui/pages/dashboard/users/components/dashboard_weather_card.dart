import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/weather/tide/tide_model.dart';
import 'package:foreclair/src/data/models/weather/weather.dart';
import 'package:foreclair/src/data/models/weather/wind_direction.dart';
import 'package:foreclair/src/data/services/app/weather_service.dart';
import 'package:foreclair/src/ui/components/indicator/maree_indicator.dart';
import 'package:foreclair/utils/units/size_utils.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherCard extends StatefulWidget {
  final VoidCallback? onTap;

  const WeatherCard({super.key, required this.onTap});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  late Future<Weather> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = WeatherService.instance.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateTime now = DateTime.now();

    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: theme.colorScheme.primaryContainer,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 4,
        child: SizedBox(
          height: context.height(25),
          child: FutureBuilder(
              future: _weatherFuture,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data!;
                final WindDirection windDirection = getWindDirection(data.windDirection);

                return Stack(
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
                              _buildTopStat(context, "${data.airTemperature} °C", "air", CupertinoIcons.thermometer_sun),
                              _buildTopStat(context, "${data.seaTemperature} °C", "eau", CupertinoIcons.drop),
                            ],
                          ),

                          const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildBottomStat(context, "${data.windSpeed} km/h", "Vent", CupertinoIcons.wind),
                              _buildBottomStat(context, windDirection.title, "Direction", windDirection.icon),
                              _buildBottomStat(context, data.uv.toString(), "UV", getWeatherIcon(data.weatherCode)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
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

  IconData getWeatherIcon(int wmoCode) {
    if (wmoCode == 0) {
      return WeatherIcons.day_sunny;
    } else if (wmoCode >= 1 && wmoCode <= 3) {
      return WeatherIcons.day_cloudy;
    } else if (wmoCode >= 45 && wmoCode <= 49) {
      return WeatherIcons.fog;
    } else if (wmoCode >= 50 && wmoCode <= 59) {
      return WeatherIcons.showers;
    } else if (wmoCode >= 60 && wmoCode <= 69) {
      return WeatherIcons.rain;
    } else if (wmoCode >= 70 && wmoCode <= 79) {
      return WeatherIcons.snow;
    } else if (wmoCode >= 80 && wmoCode <= 99) {
      return WeatherIcons.thunderstorm;
    } else {
      return WeatherIcons.na;
    }
  }

  WindDirection getWindDirection(double degrees) {
    if (degrees < 0 || degrees > 360) {
      throw ArgumentError('The wind direction must be between 0 and 360');
    }

    if (degrees >= 337.5 || degrees < 22.5) {
      return WindDirection('N', CupertinoIcons.arrow_up);
    } else if (degrees >= 22.5 && degrees < 67.5) {
      return WindDirection('N/E', CupertinoIcons.arrow_up_right);
    } else if (degrees >= 67.5 && degrees < 112.5) {
      return WindDirection('E', CupertinoIcons.arrow_right);
    } else if (degrees >= 112.5 && degrees < 157.5) {
      return WindDirection('S/E', CupertinoIcons.arrow_down_right);
    } else if (degrees >= 157.5 && degrees < 202.5) {
      return WindDirection('S', CupertinoIcons.arrow_down);
    } else if (degrees >= 202.5 && degrees < 247.5) {
      return WindDirection('S/O', CupertinoIcons.arrow_down_left);
    } else if (degrees >= 247.5 && degrees < 292.5) {
      return WindDirection('O', CupertinoIcons.arrow_left);
    } else {
      return WindDirection('N/O', CupertinoIcons.arrow_up_left);
    }
  }
}
