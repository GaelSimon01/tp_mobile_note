import 'package:flutter/material.dart';
import 'package:nombre_mystere/database_helper/requestHelper.dart';

class ViewScores extends StatelessWidget {
  const ViewScores({Key? key});

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
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Une erreur s\'est produite'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final scores = snapshot.data!;
            return Center(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Partie')),
                  DataColumn(label: Text('Joueur')),
                  DataColumn(label: Text('Niveau')),
                  DataColumn(label: Text('Tentatives')),
                  DataColumn(label: Text('Gagnée')),
                ],
                rows: buildScoreDataRows(scores),
              ),
            );
          } else {
            return const Center(child: Text('Aucun score disponible'));
          }
        },
      ),
    );
  }

  List<DataRow> buildScoreDataRows(List<Map<String, dynamic>> scores) {
    return scores.map<DataRow>((score) {
      return DataRow(
        cells: [
          DataCell(Text('${score['id']}')),
          DataCell(
            FutureBuilder<List<Map<String, dynamic>>?>(
              future: RequestHelper.getPlayerById(score['id_joueur']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Erreur');
                } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                  final joueur = snapshot.data![0];
                  return Text('${joueur['nom']}');
                } else {
                  return const Text('Inconnu');
                }
              },
            ),
          ),
          DataCell(Text('${score['id_niveau']}')),
          DataCell(Text('${score['tentatives_faites']}')),
          DataCell(Text(score['gagnee'] == 1 ? 'Oui' : 'Non')),
        ],
      );
    }).toList();
  }
}
