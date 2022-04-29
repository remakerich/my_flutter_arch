import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/router/router.dart';
import 'package:myarchapp/core/widgets/app_button.dart';
import 'package:myarchapp/core/widgets/app_text_button.dart';
import 'package:myarchapp/core/widgets/input_field.dart';
import 'package:myarchapp/features/auth/providers/login_provider.dart';
import 'package:myarchapp/features/auth/providers/register_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            const _AuthStatusMessages(),
            AppInputField(
              hint: 'E-mail',
              controller: ref.read(loginProvider.notifier).emailController,
            ),
            AppInputField(
              hint: 'Password',
              controller: ref.read(loginProvider.notifier).passwordController,
              isObscure: true,
            ),
            AppButton(
              label: 'Sign In',
              loading: loginState is AsyncLoading,
              onPressed: () {
                ref.read(loginProvider.notifier).signIn(context);
              },
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No account yet?'),
                  AppTextButton(
                    label: 'Register',
                    onPressed: () => context.router.push(const RegisterRoute()),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AuthStatusMessages extends ConsumerWidget {
  const _AuthStatusMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final registerState = ref.watch(registerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        registerState.maybeWhen(
          data: (isRegistered) {
            if (!isRegistered) {
              return const SizedBox();
            }
            return Text(
              'You have successfully registered an account!\n'
              'Please check your e-mail for verification link.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green[900],
                fontSize: 12,
              ),
            );
          },
          orElse: () => const SizedBox(),
        ),
        loginState.maybeWhen(
          error: (error, stackTrace) => Text(
            '$error $stackTrace',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
          orElse: () => const SizedBox(),
        ),
      ],
    );
  }
}
