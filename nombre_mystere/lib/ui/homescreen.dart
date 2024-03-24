import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nombre mystère - Game"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/game.jpg",
              width: 400,
              height: 400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => context.go('/home/play-game'),
                  child: const SizedBox(
                    height: 50,
                    child: Column(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.pink,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text("Jouer")
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => context.go('/home/view-scores'),
                  child: const SizedBox(
                    height: 50,
                    child: Column(
                      children: [
                        Icon(
                          Icons.sports_score,
                          color: Colors.pink,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text("Scores")
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => context.go('/home/info'),
                  child: const SizedBox(
                    height: 50,
                    child: Column(
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.pink,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text("Règles")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
