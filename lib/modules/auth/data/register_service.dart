import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';
import 'package:myarchapp/core/exceptions/handle_exceptions.dart';

@LazySingleton()
class RegisterService {
  const RegisterService();

  Future<Either<Failure, void>> registerAccount({
    required String email,
    required String password,
    required String name,
  }) {
    return handleExceptions(
      () async {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        await FirebaseAuth.instance.signOut();
      },
    );
  }
}
