import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/features/auth/providers/login_provider.dart';
import 'package:myarchapp/features/profile/providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile: Firebase'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(loginProvider.notifier).signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: profileState.when(
          data: (name) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.profile_circled,
                  size: 100,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
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
