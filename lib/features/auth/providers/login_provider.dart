import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/core/router/router.dart';
import 'package:myarchapp/features/auth/services/login_service.dart';

final loginProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, AsyncValue<bool>>(
  (ref) {
    return LoginNotifier(
      getIt<LoginService>(),
    );
  },
);

class LoginNotifier extends StateNotifier<AsyncValue<bool>> {
  LoginNotifier(
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

  void signIn(BuildContext context) async {
    state = const AsyncLoading();

    final result = await _loginService.signIn(
      email: emailController.text,
      password: passwordController.text,
    );

    result.when(
      left: (failure) async {
        state = AsyncError(failure);
        await Future.delayed(const Duration(seconds: 5));
        state = const AsyncData(false);
      },
      right: (_) {
        context.router.replace(const NavigationRoute());
        state = const AsyncData(true);
        passwordController.clear();
      },
    );
  }

  void signOut(BuildContext context) async {
    state = const AsyncLoading();

    final result = await _loginService.signOut();

    result.when(
      left: (failure) {
        state = AsyncError(failure);
      },
      right: (_) {
        context.router.replace(const LoginRoute());
        state = const AsyncData(true);
      },
    );
  }
}
