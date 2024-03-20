import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text("Screen A"),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go("/home/a/details");
              },
              child: const Text("Go to Details"),
            )
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text("Screen B"),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go("/home/b/details");
              },
              child: const Text("Go to Details"),
            )
          ],
        ),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text("Screen C"),
            TextButton(
                onPressed: () {
                  GoRouter.of(context).go("/home/c/details");
                },
                child: const Text("Go to Details"),
            )
          ],
        ),
      ),
    );
  }
}