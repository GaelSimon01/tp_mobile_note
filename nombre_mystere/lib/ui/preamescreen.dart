import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/database_helper/requestHelper.dart';

class PreGamePage extends StatefulWidget {
  const PreGamePage({super.key});

  @override
  _PreGamePageState createState() => _PreGamePageState();
}

class _PreGamePageState extends State<PreGamePage> {
  final TextEditingController _nameController = TextEditingController();
  int _selectedLevelId = 1;
  List<Map<String, dynamic>>? _levels;
  List<Map<String, dynamic>>? _players;

  @override
  void initState() {
    super.initState();
    _fetchLevels();
    _fetchAllPlayers();
  }

  Future<void> _fetchLevels() async {
    List<Map<String, dynamic>>? levels = await RequestHelper.getAllNiveaux();
    setState(() {
      _levels = levels;
      print(_levels);
    });
  }

    Future<void> _fetchAllPlayers() async {
    List<Map<String, dynamic>>? players = await RequestHelper.getAllPlayers();
    setState(() {
      _players = players;
      print(_players);
    });
  }

  bool playerExistant(String namePlayer) {
    bool estExistant = false;
    _players?.forEach((player) {
      if (player['nom'] == _nameController.text) {
        estExistant = true;
      }
    });
    return estExistant;
  }

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
            _levels != null ? DropdownButton<int>(
                    value: _selectedLevelId,
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedLevelId = newValue!;
                      });
                    },
                    items: _levels!.map<DropdownMenuItem<int>>((level) {
                      return DropdownMenuItem<int>(
                        value: level['id'] as int,
                        child: Text(level['nom'] as String),
                      );
                    }).toList(),
                  )
                : const CircularProgressIndicator(), // Affiche un indicateur de chargement tant que les niveaux sont en cours de chargement
            ElevatedButton(
              onPressed: () async {
                String playerName = _nameController.text;
                if (playerName.isNotEmpty) {
                  if (playerExistant(playerName) == false) {
                    await RequestHelper.insertPlayer(playerName);
                    print(await RequestHelper.getAllPlayers());
                  }
                  context.go('/home/pre-game/play-game?niveau=$_selectedLevelId&player=$playerName');
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Erreur'),
                        content: const Text('Veuillez entrer votre prénom et sélectionner un niveau pour commencer le jeu.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text("Commencer le jeu"),
            ),
          ],
        ),
      ),
    );
  }
}
