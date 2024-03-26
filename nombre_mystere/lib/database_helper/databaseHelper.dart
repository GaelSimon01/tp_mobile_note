import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
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
    var db = await factory.openDatabase('./database-test5.db');
    await db.execute(''' 
      CREATE TABLE Niveau(
        id INTEGER PRIMARY KEY,
        nom TEXT,
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
      INSERT INTO Niveau (nom, nombre_tentatives, maximum)
      VALUES ('Niveau 1', 10, 25)
    ''');
    await db.execute('''
      INSERT INTO Niveau (nom, nombre_tentatives, maximum)
      VALUES ('Niveau 2',20, 100)
    ''');
    await db.execute('''
      INSERT INTO Niveau (nom, nombre_tentatives, maximum)
      VALUES ('Niveau 3',25, 200)
    ''');
    await db.execute('''
      INSERT INTO Niveau (nom, nombre_tentatives, maximum)
      VALUES ('Niveau 4',30, 500)
    ''');
    return db;
  }
}
