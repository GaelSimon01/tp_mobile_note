import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

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
  var factory = databaseFactoryFfiWeb;
  var db = await factory.openDatabase('/lib/utils/database.db');

  var niveauTableExists = Sqflite.firstIntValue(await db.rawQuery(
    "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='Niveau'",
  )) == 1;
  var joueurTableExists = Sqflite.firstIntValue(await db.rawQuery(
    "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='Joueur'",
  )) == 1;
  var partieTableExists = Sqflite.firstIntValue(await db.rawQuery(
    "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='Partie'",
  )) == 1;

  if (!niveauTableExists) {
    await db.execute('''
      CREATE TABLE Niveau(
        id INTEGER PRIMARY KEY,
        nom TEXT,
        nombre_tentatives INTEGER,
        maximum INTEGER
      )
    ''');
    await db.execute('''
      INSERT INTO Niveau (nom, nombre_tentatives, maximum)
      VALUES ('Niveau 1', 10, 25)
    ''');
    await db.execute('''
      INSERT INTO Niveau (nom, nombre_tentatives, maximum)
      VALUES ('Niveau 2',10, 100)
    ''');
    await db.execute('''
      INSERT INTO Niveau (nom, nombre_tentatives, maximum)
      VALUES ('Niveau 3',10, 500)
    ''');
    await db.execute('''
      INSERT INTO Niveau (nom, nombre_tentatives, maximum)
      VALUES ('Niveau 4',10, 1500)
    ''');
    await db.execute('''
      INSERT INTO Niveau (nom, nombre_tentatives, maximum)
      VALUES ('IMPOSSIBLE',1, 1000000)
    ''');
  }
  if (!joueurTableExists) {
    await db.execute('''
      CREATE TABLE Joueur(
        id INTEGER PRIMARY KEY,
        nom TEXT
      )
    ''');
  }
  if (!partieTableExists) {
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
  }
  return db;
}
}
