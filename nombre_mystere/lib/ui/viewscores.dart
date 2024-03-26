import 'package:flutter/material.dart';
import 'package:nombre_mystere/database_helper/requestHelper.dart';

class ViewScores extends StatelessWidget {
  const ViewScores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: RequestHelper.getAllParties(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
              );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Une erreur s\'est produite')
              );
          } else if (snapshot.hasData && snapshot.data != null) {
            final scores = snapshot.data!;
            return ListView.builder(
              itemCount: scores.length,
              itemBuilder: (context, index) {
                return DataTable(
                  columns: const [
                    DataColumn(label: Text('Partie')),
                    DataColumn(label: Text('Joueur')),
                    DataColumn(label: Text('Niveau')),
                    DataColumn(label: Text('Tentatives')),
                    DataColumn(label: Text('Gagnée')),
                  ],
                  rows: scores.map<DataRow>((score) {
                    print(score);
                    String nomJoueur = "";
                    RequestHelper.getPlayerById(score['id_joueur']).then((List<Map<String, dynamic>>? joueur) {
                      if (joueur != null && joueur.isNotEmpty) {
                        nomJoueur = joueur[0]['nom'];
                      }
                    });
                    return DataRow(
                      cells: [
                        DataCell(Text('${score['id']}')),
                        DataCell(Text(nomJoueur)),
                        DataCell(Text('${score['id_niveau']}')),
                        DataCell(Text('${score['tentatives_faites']}')),
                        DataCell(Text(score['gagnee'] == 1 ? 'Oui' : 'Non')),
                      ]
                    );
                  }).toList(),
                );
              },
            );
          } else {
            return const Center(child: Text('Aucun score disponible'));
          }
        },
      ),
    );
  }
}
