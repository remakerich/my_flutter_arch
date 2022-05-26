import 'package:dio/dio.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';

Future<Either<Failure, T>> handleExceptions<T>(
    Future<T> Function() future) async {
  try {
    final result = await future();
    return Right(result);
  } on DioError catch (error) {
    return Left(
      Failure.fromException('$error ${error.response?.data}'),
    );
  } catch (error) {
    return Left(
      Failure.fromException(error),
    );
  }
}
