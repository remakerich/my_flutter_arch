import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';

Future<Either<Failure, T>> catchException<T>(
    Future<T> Function() future) async {
  try {
    final _result = await future();
    return Right(_result);
  } catch (exception) {
    return Left(Failure.fromException(exception));
  }
}
