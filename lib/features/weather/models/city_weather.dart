import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myarchapp/features/weather/models/weather_type.dart';

part 'city_weather.freezed.dart';

@freezed
class CityWeather with _$CityWeather {
  const factory CityWeather({
    @Default('') String city,
    @Default('') String temperature,
    @Default(WeatherType.rain()) WeatherType weather,
  }) = _CityWeather;

  factory CityWeather.fromJson(Map<String, dynamic> json) {
    return CityWeather(
      city: json['name'],
      weather:
          const WeatherTypeConverter().fromJson(json['weather'][0]['main']),
      temperature: json['main']['temp'].toInt().toString(),
    );
  }
}
