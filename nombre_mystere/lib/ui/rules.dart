import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Règles du Jeu'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            'Bienvenue dans le jeu du nombre mystère ! Voici les règles :',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.0),
          Text(
            '- Il y a 4 niveaux différents qui définissent un nombre de tentatives et la plage du nombre à trouver',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            '- Vous avez n tentatives pour deviner le nombre mystère',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            '- Chaque fois que vous proposez un nombre, l\'application vous dira si le nombre mystère est plus grand, plus petit ou égal à votre proposition.',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            '- Essayez de deviner le nombre mystère en aussi peu de tentatives que possible !',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
