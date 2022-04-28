import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_test_new/core/router/router.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1st page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.router.push(const SecondRoute());
              },
              child: const Text('2nd page'),
            ),
          ],
        ),
      ),
    );
  }
}
