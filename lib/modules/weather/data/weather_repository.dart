import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/modules/weather/models/city_weather.dart';
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
