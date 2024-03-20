import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {

  const AboutScreen(
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AboutScreen"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Aller à la page d'accueil"),
            ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text("Go to home"),
            ),
            const Text("Voir l'id 123"),
            ElevatedButton(
                onPressed: () => context.go('/details/123'),
                child: const Text("Go to details by id"),
            ),
          ],
        ),
      ),
    );
  }
}