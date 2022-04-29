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
    final authState = ref.watch(authProvider);

    return authState.when(
      data: (isAuthenticated) {
        if (isAuthenticated) {
          return const NavigationPage();
        }
        return const LoginPage();
      },
      error: (error, stackTrace) => const LoginPage(),
      loading: () => const Scaffold(
        body: CupertinoActivityIndicator(),
      ),
    );
  }
}
