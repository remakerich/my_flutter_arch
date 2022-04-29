import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myarchapp/core/router/router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile: Firebase'),
        actions: [
          IconButton(
            onPressed: () => context.router.replace(const LoginRoute()),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
