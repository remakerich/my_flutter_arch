import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_test_new/features/chat/pages/chat_page.dart';
import 'package:graphql_test_new/features/navigation/pages/navigation_page.dart';

part 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      initial: true,
      page: NavigationPage,
    ),
    AutoRoute(
      page: ChatPage,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
