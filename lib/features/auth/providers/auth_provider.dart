import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/features/auth/services/login_service.dart';

final authProvider =
    StateNotifierProvider.autoDispose<AuthProvider, AsyncValue<bool>>(
  (ref) {
    return AuthProvider(
      getIt<LoginService>(),
    );
  },
);

class AuthProvider extends StateNotifier<AsyncValue<bool>> {
  AuthProvider(
    this._loginService,
  ) : super(const AsyncData(false)) {
    started();
  }

  StreamSubscription? _authListener;
  final LoginService _loginService;

  void started() async {
    state = const AsyncLoading();

    if (_authListener != null) {
      _authListener!.cancel();
    }

    _authListener = FirebaseAuth.instance.authStateChanges().listen(
      (user) async {
        if (user == null) {
          state = const AsyncData(false);
        } else {
          if (!user.emailVerified) {
            state = const AsyncError('Your e-mail is not verified yet!');
            await Future.delayed(const Duration(seconds: 2));
            await _loginService.signOut();
            state = const AsyncData(false);
            return;
          }
          state = const AsyncData(true);
        }
      },
    );
  }
}
