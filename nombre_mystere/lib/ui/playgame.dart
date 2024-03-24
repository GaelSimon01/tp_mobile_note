import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Random _random = Random();
  late int _randomNumber;
  int _remainingAttempts = 10;
  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
  }

  void _generateRandomNumber() {
    _randomNumber = _random.nextInt(100) + 1;
    _remainingAttempts = 10;
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
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, RangeTextInputFormatter(min: 0, max: 100)],
              decoration: const InputDecoration(
                hintText: "Entrez un nombre entre 0 et 100",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int guessedNumber = int.tryParse(_numberController.text) ?? 0;
                if (guessedNumber == _randomNumber) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Félicitations !"),
                      content: Text("Vous avez trouvé le nombre $_randomNumber !"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            _generateRandomNumber();
                            _numberController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text("Recommencer"),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Nombre non trouvé
                  setState(() {
                    _remainingAttempts--;
                  });
                  if (_remainingAttempts == 0) {
                    // Plus d'essais restants
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Désolé !"),
                        content: Text("Vous avez épuisé tous vos essais. Le nombre était $_randomNumber."),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              _generateRandomNumber();
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
    try {
      final int value = int.parse(newValue.text);
      if ((min == null || value >= min!) && (max == null || value <= max!)) {
        return newValue;
      }
    } catch (_) {}
    return oldValue;
  }
}
