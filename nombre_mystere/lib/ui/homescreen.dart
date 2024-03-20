import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreen"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.go('/details/123'),
              child: const Text("Go to details"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/details?search=124'),
              child: const Text("Go to details search"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/home/about'),
              child: const Text("Go to About"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/home/a'),
              child: const Text("Shell routes"),
            ),
          ],
        ),
      ),
    );
  }
}