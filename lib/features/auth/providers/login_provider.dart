import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/features/auth/services/login_service.dart';

final loginProvider =
    StateNotifierProvider.autoDispose<LoginProvider, AsyncValue<bool>>(
  (ref) {
    return LoginProvider(
      getIt<LoginService>(),
    );
  },
);

class LoginProvider extends StateNotifier<AsyncValue<bool>> {
  LoginProvider(
    this._loginService,
  ) : super(const AsyncData(false));

  final LoginService _loginService;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() async {
    state = const AsyncLoading();

    final result = await _loginService.signIn(
      email: emailController.text,
      password: passwordController.text,
    );

    result.when(
      left: (failure) => state = AsyncError(failure),
      right: (_) {
        state = const AsyncData(true);
      },
    );
  }

  void signOut() async {
    state = const AsyncLoading();

    final result = await _loginService.signOut();

    result.when(
      left: (failure) => state = AsyncError(failure),
      right: (_) {},
    );
  }
}
