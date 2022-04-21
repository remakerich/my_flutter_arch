import 'package:dio/dio.dart';
import 'package:graphql_test_new/features/weather/models/city_weather.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_repository.g.dart';

@RestApi()
@lazySingleton
abstract class WeatherRepository {
  @factoryMethod
  factory WeatherRepository(@Named('weatherDio') Dio dio) = _WeatherRepository;

  @GET('')
  Future<CityWeather> getCityWeather(
    @Query('q') String city,
  );
}
