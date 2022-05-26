import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';
import 'package:myarchapp/core/exceptions/handle_exceptions.dart';

@LazySingleton()
class LoginService {
  const LoginService();

  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  }) {
    return handleExceptions(
      () async {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw Exception('Login failed');
        }
        if (!user.emailVerified) {
          FirebaseAuth.instance.signOut();
          throw Exception('E-mail is not verified!');
        }
      },
    );
  }

  Future<Either<Failure, void>> signOut() {
    return handleExceptions(
      () => FirebaseAuth.instance.signOut(),
    );
  }

  Future<Either<Failure, bool>> isLoggedIn() {
    return handleExceptions(
      () async {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          return false;
        } else {
          return true;
        }
      },
    );
  }
}
