import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_test_new/core/models/either.dart';
import 'package:graphql_test_new/core/models/failure.dart';
import 'package:graphql_test_new/features/checkout/models/checkout_types.dart';
import 'package:graphql_test_new/features/checkout/repositories/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CheckoutService {
  const CheckoutService(
    this._checkoutRepository,
  );

  final CheckoutRepository _checkoutRepository;

  Future<Either<Failure, CheckoutTypes>> getCheckoutTypes() async {
    try {
      final result = await _checkoutRepository.getCheckoutTypes();
      return Right(result);
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }
}
