import 'package:vexana/vexana.dart';

class WeatherModel extends INetworkModel<WeatherModel> {
  String? cityName;
  String? countryCode;
  String? mainDescription;
  String? description;
  String? icon;
  double? tempMax;
  double? tempMin;
  int? pressure;

  WeatherModel();

  WeatherModel._(
      {required this.cityName,
      required this.countryCode,
      required this.mainDescription,
      required this.description,
      required this.icon,
      required this.tempMax,
      required this.tempMin,
      required this.pressure});

  @override
  WeatherModel fromJson(Map<String, dynamic> json) {
    return WeatherModel._(
        cityName: json['name'],
        countryCode: json['sys']['country'],
        mainDescription: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        icon: json['weather'][0]['icon'],
        tempMax: json['main']['temp_max'],
        tempMin: json['main']['temp_min'],
        pressure: json['main']['pressure']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': this.cityName,
      'sys': {
        'country': this.countryCode,
      },
      'weather': [
        {
          'main': this.mainDescription,
          'description': this.description,
          'icon': this.icon,
        }
      ],
      'main': {
        'temp_max': this.tempMax,
        'temp_min': this.tempMin,
        'pressure': this.pressure,
      },
    };
  }

  @override
  String toString() {
    return "WeatherModel: $cityName / $mainDescription";
  }
}
