import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shell Routes"),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Screen A",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Screen B",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Screen C",
            ),
          ],
          currentIndex: _calculatorSelectedIndex(context),
          onTap: (int index) => _onItemTapped(index, context),
      ),
    );
  }

  static int _calculatorSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith("/home/a")) {
      return 0;
    }
    if (location.startsWith("/home/b")) {
      return 1;
    }
    if (location.startsWith("/home/c")) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch(index) {
      case 0:
        GoRouter.of(context).go("/home/a");
        break;

      case 1:
        GoRouter.of(context).go("/home/b");
        break;

      case 2:
        GoRouter.of(context).go("/home/c");
        break;
    }
  }
}

class DetailsScreenNavBar extends StatelessWidget {
  final String label;

  const DetailsScreenNavBar({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Screen"),
      ),
      body: Center(
        child: Text(
          "Details for $label",
          style: Theme.of(context).textTheme.titleMedium)
      ),
    );
  }
}