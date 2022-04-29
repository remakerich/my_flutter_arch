import 'package:json_annotation/json_annotation.dart';
import 'package:myarchapp/features/weather/models/weather_type.dart';

class WeatherTypeConverter implements JsonConverter<WeatherType, String?> {
  const WeatherTypeConverter();

  static const _states = {
    'Rain': WeatherType.rain(),
    'Clouds': WeatherType.clouds(),
    'Clear': WeatherType.clear(),
  };

  @override
  WeatherType fromJson(String? value) =>
      _states[value] ?? const WeatherType.rain();

  @override
  String? toJson(WeatherType value) =>
      _states.entries.firstWhere((e) => e.value == value).key;
}
