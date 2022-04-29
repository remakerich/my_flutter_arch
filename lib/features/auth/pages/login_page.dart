import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myarchapp/core/router/router.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/widgets/app_button.dart';
import 'package:myarchapp/core/widgets/app_text_button.dart';
import 'package:myarchapp/core/widgets/input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppInputField(
                hint: 'E-mail',
              ),
              AppInputField(
                hint: 'Password',
              ),
              AppButton(
                label: 'Sign In',
                onPressed: () =>
                    context.router.replace(const NavigationRoute()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No account yet?'),
                  AppTextButton(
                    label: 'Register',
                    onPressed: () => context.router.push(const RegisterRoute()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
