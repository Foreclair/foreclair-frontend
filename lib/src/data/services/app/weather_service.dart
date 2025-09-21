import 'package:foreclair/src/data/models/weather/weather.dart';
import 'package:foreclair/src/data/services/http/api_service.dart';

import '../../dao/user_dao.dart';
import '../../models/users/user_model.dart';

class WeatherService {
  static final WeatherService _instance = WeatherService._privateConstructor();

  static WeatherService get instance => _instance;

  WeatherService._privateConstructor();

  Future<Weather> getWeather() async {
    UserModel user = UserDao.instance.currentUser!;
    final response = await ApiService.instance.get(path: "/weather/weather?longitude=${user.station.longitude}&latitude=${user.station.latitude}");
    return Weather.fromJson(response.data);
  }

}