import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';
import 'package:myarchapp/core/exceptions/handle_exceptions.dart';

@LazySingleton()
class ProfileService {
  const ProfileService();

  Future<Either<Failure, String>> getUserName() {
    return handleExceptions(
      () async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          FirebaseAuth.instance.signOut();
          throw Exception('Login failed');
        }
        final userName = user.displayName;
        if (userName == null) {
          return 'No user name provided';
        } else {
          return userName;
        }
      },
    );
  }
}
