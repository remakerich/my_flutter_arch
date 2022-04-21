import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/features/auth/providers/bottom_navigation_provider.dart';
import 'package:graphql_test_new/features/chat/pages/chat_page.dart';
import 'package:graphql_test_new/features/checkout/pages/checkout_page.dart';

class NavigationPage extends ConsumerWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavigationState = ref.watch(bottomNavigationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: bottomNavigationState,
              children: const [
                ChatPage(),
                CheckoutPage(),
              ],
            ),
          ),
          SafeArea(
            child: Container(
              height: 50,
              color: Colors.black,
              child: Row(
                children: [
                  _BottomNavBarItem(
                    onSelected: () =>
                        ref.read(bottomNavigationProvider.notifier).state = 0,
                    isSelected: bottomNavigationState == 0,
                  ),
                  _BottomNavBarItem(
                    onSelected: () =>
                        ref.read(bottomNavigationProvider.notifier).state = 1,
                    isSelected: bottomNavigationState == 1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  const _BottomNavBarItem({
    Key? key,
    required this.onSelected,
    required this.isSelected,
  }) : super(key: key);

  final VoidCallback onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onSelected,
        child: Container(
          margin: const EdgeInsets.all(2),
          color: isSelected ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
