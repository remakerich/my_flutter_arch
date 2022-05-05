import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:myarchapp/core/network/network_config.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

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
