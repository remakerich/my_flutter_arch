import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/exception_handler.dart';
import 'package:myarchapp/core/exceptions/failure.dart';
import 'package:myarchapp/features/weather/models/city_weather.dart';
import 'package:myarchapp/features/weather/repositories/weather_repository.dart';

@lazySingleton
class WeatherService {
  const WeatherService(
    this._weatherRepository,
  );

  final WeatherRepository _weatherRepository;

  Future<Either<Failure, CityWeather>> getCityWeather(String city) async {
    return await catchException(
      () => _weatherRepository.getCityWeather(city),
    );
  }
}
