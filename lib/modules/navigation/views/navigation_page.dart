import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/modules/chat/views/chat_list_page.dart';
import 'package:myarchapp/modules/navigation/controllers/bottom_navigation_provider.dart';
import 'package:myarchapp/modules/profile/views/profile_page.dart';
import 'package:myarchapp/modules/weather/views/weather_page.dart';

class NavigationPage extends ConsumerWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavigationState = ref.watch(bottomNavigationProvider);
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.accent,
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: bottomNavigationState,
              children: const [
                ChatListPage(),
                WeatherPage(),
                ProfilePage(),
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                const SizedBox(width: AppShapes.padding),
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
                _BottomNavBarItem(
                  onSelected: () {
                    HapticFeedback.mediumImpact();
                    ref.read(bottomNavigationProvider.notifier).state = 2;
                  },
                  isSelected: bottomNavigationState == 2,
                  icon: CupertinoIcons.profile_circled,
                ),
                const SizedBox(width: AppShapes.padding),
              ],
            ),
          ),
          SizedBox(height: bottomSafeArea),
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
