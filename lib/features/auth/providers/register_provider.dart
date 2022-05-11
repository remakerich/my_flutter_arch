import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/features/auth/services/register_service.dart';

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, AsyncValue<bool>>(
  (ref) {
    return RegisterNotifier(
      getIt<RegisterService>(),
    );
  },
);

class RegisterNotifier extends StateNotifier<AsyncValue<bool>> {
  RegisterNotifier(
    this._registerService,
  ) : super(const AsyncData(false));

  final RegisterService _registerService;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void registerAccount(BuildContext context) async {
    state = const AsyncLoading();

    final result = await _registerService.registerAccount(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );

    result.when(
      left: (failure) => state = AsyncError(failure),
      right: (_) async {
        context.router.pop();
        state = const AsyncData(true);
        nameController.clear();
        emailController.clear();
        passwordController.clear();
      },
    );
  }
}
