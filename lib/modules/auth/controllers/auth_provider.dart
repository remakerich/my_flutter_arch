import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/modules/auth/data/login_service.dart';

final authProvider = StateNotifierProvider.autoDispose<AuthProvider, bool>(
  (ref) {
    return AuthProvider(
      getIt<LoginService>(),
    );
  },
);

class AuthProvider extends StateNotifier<bool> {
  AuthProvider(
    this._loginService,
  ) : super(false) {
    isLoggedIn();
  }

  final LoginService _loginService;

  Future<void> isLoggedIn() async {
    final result = await _loginService.isLoggedIn();

    result.when(
      left: (failure) => state = false,
      right: (isLoggedIn) => state = isLoggedIn,
    );
  }
}
