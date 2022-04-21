import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/features/chat/pages/chats_list_tab.dart';
import 'package:graphql_test_new/features/chat/providers/user_name_provider.dart';
import 'package:graphql_test_new/features/checkout/pages/checkout_page.dart';
import 'package:graphql_test_new/features/navigation/providers/bottom_navigation_provider.dart';

class NavigationPage extends ConsumerWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavigationState = ref.watch(bottomNavigationProvider);
    ref.watch(userNameProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: bottomNavigationState,
              children: const [
                ChatsListTab(),
                CheckoutPage(),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: SizedBox(
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  _BottomNavBarItem(
                    onSelected: () {
                      HapticFeedback.mediumImpact();
                      ref.read(bottomNavigationProvider.notifier).state = 0;
                    },
                    isSelected: bottomNavigationState == 0,
                    icon: CupertinoIcons.chat_bubble_2,
                  ),
                  _BottomNavBarItem(
                    onSelected: () {
                      HapticFeedback.mediumImpact();
                      FocusManager.instance.primaryFocus?.unfocus();
                      ref.read(bottomNavigationProvider.notifier).state = 1;
                    },
                    isSelected: bottomNavigationState == 1,
                    icon: CupertinoIcons.cloud_drizzle,
                  ),
                  const SizedBox(width: 10),
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
    required this.icon,
  }) : super(key: key);

  final VoidCallback onSelected;
  final bool isSelected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onSelected,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? Colors.grey[200] : Colors.transparent,
          ),
          child: Icon(
            icon,
            size: 30,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
