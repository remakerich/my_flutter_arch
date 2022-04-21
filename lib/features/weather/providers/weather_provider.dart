import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/core/injection/injection.dart';
import 'package:graphql_test_new/features/weather/models/city_weather.dart';
import 'package:graphql_test_new/features/weather/services/weather_service.dart';

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
  ) : super(const AsyncData(CityWeather()));

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