import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/database_helper/requestHelper.dart';

class GamePage extends StatefulWidget {
  final int niveau;
  final String player;

  const GamePage({super.key, required this.niveau, required this.player});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Random _random = Random();
  final TextEditingController _numberController = TextEditingController();

  late int _randomNumber, _remainingAttempts = 0, _plageMax = 0;
  int maxTentatives = 0;
  String indication = "";
  bool estGagne = false;
  late List<Map<String, dynamic>> playerActuel;

  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
    _getInfosPlayer();
  }

  Future<void> _generateRandomNumber() async {
    List<Map<String, dynamic>>? niveauInfos = await RequestHelper.getNiveau(widget.niveau);
    print(niveauInfos);
    int randomNumber = _random.nextInt(niveauInfos?[0]['maximum']) + 1;
    int plageMax = niveauInfos?[0]['maximum'];
    int remainingAttempts = niveauInfos?[0]['nombre_tentatives'];
    setState(() {
      _randomNumber = randomNumber;
      _plageMax = plageMax;
      _remainingAttempts = remainingAttempts;
      maxTentatives = remainingAttempts;
    });
  }

  Future<void> _getInfosPlayer() async {
    playerActuel = (await RequestHelper.getPlayerInfos(widget.player))!;
    print(playerActuel);
  }

  void resetStatusGame() {
    indication = "";
    estGagne = false;
    maxTentatives = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page de jeu - Nombre mystère"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Il vous reste $_remainingAttempts essais"),
            Text(indication),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, RangeTextInputFormatter( min: 0 ,max: _plageMax)],
              decoration: InputDecoration(
                hintText: "Entrez un nombre entre 0 et $_plageMax",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int guessedNumber = int.tryParse(_numberController.text) ?? 0;
                if(_numberController.text==""){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Erreur'),
                      content: const Text('Veuillez entrer un nombre'),
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
                else if (guessedNumber == _randomNumber) {
                  estGagne = true;
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Félicitations !"),
                      content: Text("Vous avez trouvé le nombre $_randomNumber !"),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            resetStatusGame();
                            await _generateRandomNumber();
                            _numberController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text("Recommencer"),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await RequestHelper.insertGame(playerActuel[0]['id'], widget.niveau, maxTentatives-_remainingAttempts, estGagne);
                              print(await RequestHelper.getPlayerGames(playerActuel[0]['id']));
                              context.go('/');
                            },
                            child: const Text("Enregistrer la partie"),
                          ),
                      ],
                    ),
                  );
                } else {
                    setState(() {
                      _remainingAttempts--;
                      _numberController.clear();
                    });
                    if (guessedNumber < _randomNumber) {
                      setState(() {
                        indication = "Plus haut";
                      });
                    }
                    else if (guessedNumber > _randomNumber) {
                      setState(() {
                        indication = "Plus bas";
                      });
                    }
                  if (_remainingAttempts == 0) {
                    // Plus d'essais restants
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Désolé !"),
                        content: Text("Vous avez épuisé tous vos essais. Le nombre était $_randomNumber."),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              resetStatusGame();
                              await _generateRandomNumber();
                              _numberController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("Recommencer"),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: const Text("Valider"),
            ),
          ],
        ),
      ),
    );
  }
}

class RangeTextInputFormatter extends TextInputFormatter {
  final int? min;
  final int? max;

  RangeTextInputFormatter({this.min, this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text==""){
      return newValue;
    }
    try {
      final int value = int.parse(newValue.text);
      if ((min == null || value >= min!) && (max == null || value <= max!)) {
        return newValue;
      }
    } catch (_) {}
    return oldValue;
  }
}
