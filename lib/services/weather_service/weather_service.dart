import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vexana/vexana.dart';
import 'package:vexana_example/models/weather_model.dart';

import 'i_weather_service.dart';

class WeatherService extends IWeatherService {
  final NetworkManager _networkManager = NetworkManager(
      options: BaseOptions(
          baseUrl: 'http://api.openweathermap.org',
          queryParameters: {
        'appid': dotenv.env['API_KEY'],
        'units': 'metric',
        'lang': 'tr',
      }));

  @override
  Future<WeatherModel> getWeather(String city) async {
    if (city == "") {
      return Future.error(WeatherServiceException);
    }
    try {
      final response = await _networkManager.send(
        "/data/2.5/weather",
        parseModel: WeatherModel(),
        method: RequestType.GET,
        queryParameters: {'q': city},
      );

      if (response.data is WeatherModel) {
        return response.data;
      }
    } catch (e) {
      return Future.error(WeatherServiceException);
    }

    return Future.error(WeatherServiceException);
  }

  // Çalıştıramadım :/
  @override
  Future<Uint8List> getWeatherImage(String code) async {
    final response = await _networkManager.downloadFileSimple(
        "/img/wn/${code}@2x.png", (_, __) {});
    print(response.data);
    return Future.error(WeatherServiceException);
  }
}

class WeatherServiceException extends Exception {
  factory WeatherServiceException() => WeatherServiceException();
}
