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
