import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_type.freezed.dart';
part 'weather_type.g.dart';

@freezed
class WeatherType with _$WeatherType {
  const factory WeatherType.rain() = WeatherRain;
  const factory WeatherType.clouds() = WeatherClouds;
  const factory WeatherType.clear() = WeatherClear;

  factory WeatherType.fromJson(Map<String, dynamic> json) =>
      _$WeatherTypeFromJson(json);
}

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
