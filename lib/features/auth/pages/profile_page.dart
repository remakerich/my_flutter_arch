import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/features/auth/providers/login_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile: Firebase'),
        actions: [
          IconButton(
            onPressed: () => ref.read(loginProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
