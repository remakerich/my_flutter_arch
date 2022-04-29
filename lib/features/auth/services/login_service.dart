import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/exception_handler.dart';
import 'package:myarchapp/core/exceptions/failure.dart';

@LazySingleton()
class LoginService {
  const LoginService();

  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  }) async {
    return await catchException(
      () async {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      },
    );
  }

  Future<Either<Failure, void>> signOut() async {
    return await catchException(
      () => FirebaseAuth.instance.signOut(),
    );
  }
}
