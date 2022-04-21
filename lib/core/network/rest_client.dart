import 'package:graphql_test_new/core/network/network_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectableModule {
  @LazySingleton()
  @Named('weatherDio')
  Dio weatherDio() {
    return Dio(
      BaseOptions(
        baseUrl: NetworkConfig.weatherApiUrl,
        queryParameters: {
          'appid': 'a3d77f43f166bfd1905b1c53e6f92aaf',
          'units': 'metric',
        },
      ),
    );
  }
}
