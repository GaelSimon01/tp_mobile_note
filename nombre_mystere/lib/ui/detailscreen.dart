import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  final int id;

  const DetailScreen(
      {super.key, required this.id}
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DetailsScreen"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Voici l'id : $id"),
            ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text("Go to home"),
            )
          ],
        ),
      ),
    );
  }
}