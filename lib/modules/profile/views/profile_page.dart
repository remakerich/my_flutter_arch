import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/router/router.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/modules/profile/controllers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      body: Center(
        child: profileState.when(
          data: (name) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Icon(
                      CupertinoIcons.profile_circled,
                      size: 100,
                      color: Colors.grey[400],
                    ),
                    const Positioned(
                      right: -5,
                      bottom: -5,
                      child: _RotatingGear(),
                    ),
                  ],
                ),
                const SizedBox(height: AppShapes.padding),
                Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            );
          },
          error: (error, stackTrace) => Text('$error $stackTrace'),
          loading: () => const CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class _RotatingGear extends StatefulWidget {
  const _RotatingGear({Key? key}) : super(key: key);

  @override
  State<_RotatingGear> createState() => __RotatingGearState();
}

class __RotatingGearState extends State<_RotatingGear>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: IconButton(
        onPressed: () {
          context.router.push(const SettingsRoute());
        },
        icon: const Icon(
          CupertinoIcons.gear_alt_fill,
          color: AppColors.accent,
        ),
      ),
    );
  }
}
