import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/modules/auth/controllers/auth_provider.dart';
import 'package:myarchapp/modules/auth/views/login_page.dart';
import 'package:myarchapp/modules/navigation/views/navigation_page.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSignedIn = ref.watch(authProvider);

    if (isSignedIn) {
      return const NavigationPage();
    }
    return const LoginPage();
  }
}
