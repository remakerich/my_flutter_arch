import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';

@LazySingleton()
class RegisterService {
  const RegisterService();

  Future<Either<Failure, void>> registerAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }
}
