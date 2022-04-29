import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myarchapp/features/auth/pages/auth_page.dart';
import 'package:myarchapp/features/auth/pages/login_page.dart';
import 'package:myarchapp/features/auth/pages/register_page.dart';
import 'package:myarchapp/features/chat/pages/chat_page.dart';
import 'package:myarchapp/features/navigation/pages/navigation_page.dart';

part 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(initial: true, page: AuthPage),
    AutoRoute(page: NavigationPage),
    AutoRoute(page: ChatPage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegisterPage),
  ],
)
class AppRouter extends _$AppRouter {}
