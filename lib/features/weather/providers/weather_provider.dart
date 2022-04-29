import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/features/weather/models/city_weather.dart';
import 'package:myarchapp/features/weather/services/weather_service.dart';

final weatherProvider =
    StateNotifierProvider.autoDispose<WeatherNotifier, AsyncValue<CityWeather>>(
  (ref) {
    return WeatherNotifier(
      getIt<WeatherService>(),
    );
  },
);

class WeatherNotifier extends StateNotifier<AsyncValue<CityWeather>> {
  WeatherNotifier(
    this._weatherService,
  ) : super(const AsyncData(CityWeather())) {
    started('New Delhi');
  }

  final WeatherService _weatherService;

  void started(String city) async {
    state = const AsyncLoading();

    final result = await _weatherService.getCityWeather(city);

    result.when(
      left: (failure) => state = AsyncError(failure),
      right: (weather) => state = AsyncData(weather),
    );
  }
}
