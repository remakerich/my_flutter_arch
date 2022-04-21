import 'package:dio/dio.dart';
import 'package:graphql_test_new/core/network/network_config.dart';
import 'package:graphql_test_new/features/checkout/models/checkout_types.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'checkout_repository.g.dart';

@RestApi(baseUrl: NetworkConfig.electroBazaTestUrl)
@lazySingleton
abstract class CheckoutRepository {
  @factoryMethod
  factory CheckoutRepository(Dio dio) = _CheckoutRepository;

  @GET('checkout')
  Future<CheckoutTypes> getCheckoutTypes();
}
