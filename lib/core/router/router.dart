import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myarchapp/modules/auth/views/auth_page.dart';
import 'package:myarchapp/modules/auth/views/login_page.dart';
import 'package:myarchapp/modules/auth/views/register_page.dart';
import 'package:myarchapp/modules/chat/views/chat_page.dart';
import 'package:myarchapp/modules/navigation/views/navigation_page.dart';
import 'package:myarchapp/modules/settings/views/about_app_page.dart';
import 'package:myarchapp/modules/settings/views/settings_page.dart';

part 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(initial: true, page: AuthPage),
    AutoRoute(page: NavigationPage),
    AutoRoute(page: ChatPage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegisterPage),
    AutoRoute(page: SettingsPage),
    AutoRoute(page: AboutAppPage),
  ],
)
class AppRouter extends _$AppRouter {}
