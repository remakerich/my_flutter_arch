import 'package:graphql_test_new/core/exceptions/either.dart';
import 'package:graphql_test_new/core/exceptions/exception_handler.dart';
import 'package:graphql_test_new/core/exceptions/failure.dart';
import 'package:graphql_test_new/features/weather/models/city_weather.dart';
import 'package:graphql_test_new/features/weather/repositories/weather_repository.dart';
import 'package:injectable/injectable.dart';

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
