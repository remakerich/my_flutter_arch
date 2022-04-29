import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';

@LazySingleton()
class ProfileService {
  const ProfileService();

  Either<Failure, String> getUserName() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        FirebaseAuth.instance.signOut();
        throw Exception('Login failed');
      }
      final userName = user.displayName;
      if (userName == null) {
        return const Right('No user name provided');
      } else {
        return Right(userName);
      }
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }
}
