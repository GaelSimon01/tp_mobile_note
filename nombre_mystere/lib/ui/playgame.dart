import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/database_helper/requestHelper.dart';

class GamePage extends StatefulWidget {
  final int niveau;
  final String player;

  const GamePage({Key? key, required this.niveau, required this.player}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Random _random = Random();
  final TextEditingController _numberController = TextEditingController();

  late int _randomNumber, _remainingAttempts = 0, _plageMax = 0;
  int _maxTentatives = 0;
  String _indication = "";
  bool _estGagne = false;
  late List<Map<String, dynamic>> _playerActuel;
  late int _dernierNombreTestes = 0;

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
      _maxTentatives = remainingAttempts;
    });
  }

  Future<void> _getInfosPlayer() async {
    _playerActuel = (await RequestHelper.getPlayerInfos(widget.player))!;
    print(_playerActuel);
  }

  void resetStatusGame() {
    _indication = "";
    _estGagne = false;
    _maxTentatives = 0;
  }

  void _validateNumber() {
    int guessedNumber = int.tryParse(_numberController.text) ?? 0;
    if(_numberController.text.isEmpty){
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
    else {
      setState(() {
        _remainingAttempts--;
        _dernierNombreTestes = guessedNumber;
        _numberController.clear();
      });
      if (guessedNumber == _randomNumber) {
        _estGagne = true;
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
                  Navigator.pop(context);
                },
                child: const Text("Recommencer"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await RequestHelper.insertGame(_playerActuel[0]['id'], widget.niveau, _maxTentatives-_remainingAttempts, _estGagne);
                  print(await RequestHelper.getPlayerGames(_playerActuel[0]['id']));
                  context.go('/home/pre-game');
                },
                child: const Text("Enregistrer la partie"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await RequestHelper.insertGame(_playerActuel[0]['id'], widget.niveau, _maxTentatives-_remainingAttempts, _estGagne);
                  print(await RequestHelper.getPlayerGames(_playerActuel[0]['id']));
                  context.go('/home/pre-game?niveau=${widget.niveau+1}&player=${_playerActuel[0]['nom']}');
                },
                child: const Text("Niveau suivant"),
              ),
            ],
          ),
        );
      } else {
        if (guessedNumber < _randomNumber) {
          setState(() {
            _indication = "Plus haut";
          });
        } else if (guessedNumber > _randomNumber) {
          setState(() {
            _indication = "Plus bas";
          });
        }
        if (_remainingAttempts == 0) {
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
                    Navigator.pop(context);
                  },
                  child: const Text("Recommencer"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await RequestHelper.insertGame(_playerActuel[0]['id'], widget.niveau, _maxTentatives-_remainingAttempts, _estGagne);
                    print(await RequestHelper.getPlayerGames(_playerActuel[0]['id']));
                    context.go('/home/pre-game');
                  },
                  child: const Text("Enregistrer la partie"),
                ),
              ],
            ),
          );
        }
      }
    }
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
            Text("Bienvenue ${widget.player}", style: const TextStyle(fontSize: 30),),
            const Padding(padding: EdgeInsets.all(16.0)),
            Text("Il vous reste $_remainingAttempts essai(s)"),
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(_indication, style: const TextStyle(fontWeight: FontWeight.bold),),
            const Padding(padding: EdgeInsets.all(16.0)),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, RangeTextInputFormatter( min: 0 ,max: _plageMax)],
                  decoration: InputDecoration(
                    hintText: "Entrez un nombre entre 0 et $_plageMax",
                  ),
                  onSubmitted: (_) {
                    _validateNumber();
                  },
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            Text("Dernier nombre testé : $_dernierNombreTestes"),
            const Padding(padding: EdgeInsets.all(20.0)),
            ElevatedButton(
              onPressed: _validateNumber,
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
