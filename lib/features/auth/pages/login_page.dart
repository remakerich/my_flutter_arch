import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/router/router.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/widgets/app_button.dart';
import 'package:myarchapp/core/widgets/app_text_button.dart';
import 'package:myarchapp/core/widgets/input_field.dart';
import 'package:myarchapp/core/widgets/language_bottom_sheet.dart';
import 'package:myarchapp/core/l10n/localization.dart';
import 'package:myarchapp/core/widgets/smooth_transition_appbar.dart';
import 'package:myarchapp/features/auth/providers/login_provider.dart';
import 'package:myarchapp/features/auth/providers/register_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final locale = AppLocalizations.of(context)!;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: SmoothTransitionAppBar(
        title: locale.login,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: AppShapes.bottomSheetShape,
                context: context,
                builder: (context) => const LanguageBottomSheet(),
              );
            },
            icon: const Icon(
              Icons.language,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            const _AuthStatusMessages(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppInputField(
                    hint: 'E-mail',
                    controller:
                        ref.read(loginProvider.notifier).emailController,
                    hasDefaultValidator: true,
                    defaultValidatorErrorMessage: '${locale.enter} e-mail',
                  ),
                  AppInputField(
                    hint: locale.password,
                    controller:
                        ref.read(loginProvider.notifier).passwordController,
                    isObscure: true,
                    hasDefaultValidator: true,
                    defaultValidatorErrorMessage:
                        '${locale.enter} ${locale.password}',
                  ),
                ],
              ),
            ),
            AppButton(
              label: locale.login,
              loading: loginState is AsyncLoading,
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                ref.read(loginProvider.notifier).signIn(context);
              },
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(locale.noAccountYet),
                  AppTextButton(
                    label: locale.register,
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
    final locale = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        registerState.maybeWhen(
          data: (isRegistered) {
            if (!isRegistered) {
              return const SizedBox();
            }
            return Text(
              locale.registrationSuccessful,
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
