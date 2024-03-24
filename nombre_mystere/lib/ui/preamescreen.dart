import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreGamePage extends StatefulWidget {
  const PreGamePage({Key? key}) : super(key: key);

  @override
  _PreGamePageState createState() => _PreGamePageState();
}

class _PreGamePageState extends State<PreGamePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Préparation du jeu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Entrez votre prénom",
                labelText: "Prénom",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //String playerName = _nameController.text;
                context.go('/home/pre-game/play-game');
              },
              child: const Text("Commencer le jeu"),
            ),
          ],
        ),
      ),
    );
  }
}
