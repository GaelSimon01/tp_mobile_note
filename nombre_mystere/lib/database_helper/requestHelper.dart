import 'package:sqflite/sqflite.dart';
import 'databaseHelper.dart';

class RequestHelper {
  static Future<void> insertPlayer(String playerName) async {
    Database? db = await DatabaseHelper.getDatabase();
    await db?.insert('Joueur', {'nom': playerName});
  }

  static Future<void> insertGame(int playerId, int niveauId, int tentativesFaites, bool aGagnee) async {
    Database? db = await DatabaseHelper.getDatabase();
    await db?.insert('Partie', {
      'id_joueur': playerId,
      'id_niveau': niveauId,
      'tentatives_faites': tentativesFaites,
      'gagnee': aGagnee ? 1 : 0,
    });
  }

  static Future<List<Map<String, dynamic>>?> getPlayerGames(int playerId) async {
    Database? db = await DatabaseHelper.getDatabase();
    return await db?.rawQuery('''
      SELECT * FROM Partie WHERE id_joueur = ?
    ''', [playerId]);
  }

  static Future<List<Map<String, dynamic>>?> getAllPlayers() async {
    Database? db = await DatabaseHelper.getDatabase();
    return await db?.query('Joueur');
  }

    static Future<List<Map<String, dynamic>>?> getAllNiveaux() async {
    Database? db = await DatabaseHelper.getDatabase();
    return await db?.query('Niveau');
  }
}
