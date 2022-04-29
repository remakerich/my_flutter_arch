import 'package:flutter/material.dart';
import 'package:myarchapp/core/widgets/app_button.dart';
import 'package:myarchapp/core/widgets/input_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppInputField(
                hint: 'Name',
              ),
              AppInputField(
                hint: 'E-mail',
              ),
              AppInputField(
                hint: 'Password',
              ),
              AppButton(
                label: 'Register',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
