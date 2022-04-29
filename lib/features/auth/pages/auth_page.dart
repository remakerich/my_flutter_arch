import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/features/auth/pages/login_page.dart';
import 'package:myarchapp/features/auth/providers/auth_provider.dart';
import 'package:myarchapp/features/navigation/pages/navigation_page.dart';

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
