import 'dart:typed_data';

import 'package:vexana/vexana.dart';
import 'package:vexana_example/models/weather_model.dart';

abstract class IWeatherService {
  Future<WeatherModel> getWeather(String city);
  Future<Uint8List> getWeatherImage(String code);
}
