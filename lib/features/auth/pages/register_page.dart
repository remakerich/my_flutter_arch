import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/widgets/app_button.dart';
import 'package:myarchapp/core/widgets/input_field.dart';
import 'package:myarchapp/features/auth/providers/register_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerProvider);
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.register),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            const _RegisterResultMessage(),
            AppInputField(
              hint: 'Name',
              controller: ref.read(registerProvider.notifier).nameController,
            ),
            AppInputField(
              hint: 'E-mail',
              controller: ref.read(registerProvider.notifier).emailController,
            ),
            AppInputField(
              hint: 'Password',
              isObscure: true,
              controller:
                  ref.read(registerProvider.notifier).passwordController,
            ),
            SafeArea(
              child: AppButton(
                label: 'Register',
                loading: registerState is AsyncLoading,
                onPressed: () {
                  ref.read(registerProvider.notifier).registerAccount(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterResultMessage extends ConsumerWidget {
  const _RegisterResultMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerProvider);

    return registerState.maybeWhen(
      error: (error, stackTrace) => Text(
        '$error $stackTrace',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
      orElse: () => const SizedBox(),
    );
  }
}
