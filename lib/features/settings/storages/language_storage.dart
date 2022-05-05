import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';

@LazySingleton()
class LanguageStorage {
  const LanguageStorage(
    this._secureStorage,
  );

  final FlutterSecureStorage _secureStorage;

  static const key = 'Language Settings';

  Future<Either<Failure, void>> setLanguage({
    required String language,
  }) async {
    try {
      await _secureStorage.write(
        key: key,
        value: jsonEncode(language),
      );
      return const Right(null);
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }

  Future<Either<Failure, String>> getLanguage() async {
    try {
      final result = await _secureStorage.read(key: key);

      return Right(result!.replaceAll('"', ''));
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }
}
