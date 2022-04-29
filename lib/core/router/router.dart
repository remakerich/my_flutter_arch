import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myarchapp/features/chat/pages/chat_page.dart';
import 'package:myarchapp/features/navigation/pages/navigation_page.dart';

part 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(initial: true, page: NavigationPage),
    AutoRoute(page: ChatPage),
  ],
)
class AppRouter extends _$AppRouter {}
