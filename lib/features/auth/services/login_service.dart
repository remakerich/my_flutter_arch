import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';

@LazySingleton()
class LoginService {
  const LoginService();

  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  }) async {
    try {
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
      return const Right(null);
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }

  Either<Failure, bool> isLoggedIn() {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return const Right(false);
      } else {
        return const Right(true);
      }
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }
}
