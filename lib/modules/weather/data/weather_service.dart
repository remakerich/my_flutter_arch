import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';
import 'package:myarchapp/core/exceptions/handle_exceptions.dart';
import 'package:myarchapp/modules/weather/data/weather_repository.dart';
import 'package:myarchapp/modules/weather/models/city_weather.dart';

@lazySingleton
class WeatherService {
  const WeatherService(
    this._weatherRepository,
  );

  final WeatherRepository _weatherRepository;

  Future<Either<Failure, CityWeather>> getCityWeather(String city) {
    return handleExceptions(
      () => _weatherRepository.getCityWeather(city),
    );
  }
}
