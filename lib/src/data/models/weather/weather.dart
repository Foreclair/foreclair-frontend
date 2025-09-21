class Weather {
  final int weatherCode;
  final double airTemperature;
  final double seaTemperature;
  final double windSpeed;
  final double windDirection;
  final double uv;

  Weather(this.weatherCode, this.airTemperature, this.seaTemperature, this.windSpeed,
      this.windDirection, this.uv);

  factory Weather.fromJson(data) {
    return Weather(
        data['weatherCode'],
        data['airTemperature'],
        data['seaTemperature'],
        data['windSpeed'],
        data['windDirection'],
        data['uv']);
  }
}