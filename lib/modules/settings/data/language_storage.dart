import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';
import 'package:myarchapp/core/exceptions/handle_exceptions.dart';

@LazySingleton()
class LanguageStorage {
  const LanguageStorage(
    this._secureStorage,
  );

  final FlutterSecureStorage _secureStorage;

  static const key = 'Language Settings';

  Future<Either<Failure, void>> setLanguage({
    required String language,
  }) {
    return handleExceptions(
      () => _secureStorage.write(
        key: key,
        value: language,
      ),
    );
  }

  Future<Either<Failure, String>> getLanguage() {
    return handleExceptions(
      () async {
        final result = await _secureStorage.read(key: key) ?? '';
        return result;
      },
    );
  }
}
