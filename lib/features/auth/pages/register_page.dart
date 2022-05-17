import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myarchapp/core/widgets/app_button.dart';
import 'package:myarchapp/core/widgets/easter_egg.dart';
import 'package:myarchapp/core/widgets/input_field.dart';
import 'package:myarchapp/core/l10n/localization.dart';
import 'package:myarchapp/features/auth/providers/register_provider.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerProvider);
    final locale = AppLocalizations.of(context)!;
    final _formKey = GlobalKey<FormState>();

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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppInputField(
                    hint: locale.name,
                    controller:
                        ref.read(registerProvider.notifier).nameController,
                    hasDefaultValidator: true,
                    defaultValidatorErrorMessage:
                        '${locale.enter} ${locale.name}',
                  ),
                  AppInputField(
                    hint: 'Phone',
                    controller:
                        ref.read(registerProvider.notifier).phoneController,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '+# (###) ###-##-##',
                      ),
                    ],
                  ),
                  AppInputField(
                    hint: 'E-mail',
                    controller:
                        ref.read(registerProvider.notifier).emailController,
                    hasDefaultValidator: true,
                    defaultValidatorErrorMessage: '${locale.enter} e-mail',
                  ),
                  AppInputField(
                    hint: locale.password,
                    isObscure: true,
                    controller:
                        ref.read(registerProvider.notifier).passwordController,
                    hasDefaultValidator: true,
                    defaultValidatorErrorMessage:
                        '${locale.enter} ${locale.password}',
                  ),
                  const EasterEgg(),
                ],
              ),
            ),
            SafeArea(
              child: AppButton(
                label: locale.register,
                loading: registerState is AsyncLoading,
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
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
