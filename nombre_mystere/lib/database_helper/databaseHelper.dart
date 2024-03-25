import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database?> getDatabase() async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'database.db');
    Database db = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Niveau(
            id INTEGER PRIMARY KEY,
            nombre_tentatives INTEGER,
            maximum INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE Joueur(
            id INTEGER PRIMARY KEY,
            nom TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE Partie(
            id INTEGER PRIMARY KEY,
            id_joueur INTEGER,
            id_niveau INTEGER,
            tentatives_faites INTEGER,
            gagnee INTEGER,
            FOREIGN KEY (id_joueur) REFERENCES Joueur(id),
            FOREIGN KEY (id_niveau) REFERENCES Niveau(id)
          )
        ''');
        await db.execute('''
          INSERT INTO Niveau (nombre_tentatives, maximum)
          VALUES (10, 25)
        ''');
        await db.execute('''
          INSERT INTO Niveau (nombre_tentatives, maximum)
          VALUES (20, 100)
        ''');
        await db.execute('''
          INSERT INTO Niveau (nombre_tentatives, maximum)
          VALUES (25, 200)
        ''');
        await db.execute('''
          INSERT INTO Niveau (nombre_tentatives, maximum)
          VALUES (30, 500)
        ''');
      },
      version: 1,
    );
    return db;
  }
}
