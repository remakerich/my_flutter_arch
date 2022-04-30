import 'package:flutter/material.dart';
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
    started();
  }

  final WeatherService _weatherService;
  final cityController = TextEditingController(text: 'New Delhi');

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  void started() async {
    state = const AsyncLoading();

    final result = await _weatherService.getCityWeather(cityController.text);

    result.when(
      left: (failure) => state = AsyncError(failure),
      right: (weather) => state = AsyncData(weather),
    );
  }
}
