import 'package:graphql_test_new/core/models/either.dart';
import 'package:graphql_test_new/core/models/failure.dart';
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
    try {
      final result = await _weatherRepository.getCityWeather(city);
      return Right(result);
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }
}
