import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:food_app/models/item.dart';




class DatabaseHelper {
  static late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;

  }
  // Méthode pour ajouter un nouvel élément à la base de données
  Future<void> addItem(Item newItem) async {
    // Logique pour ajouter l'élément à la base de données
    try {
      // Exemple d'utilisation de sqflite pour l'insertion
      await _database.insert('items', newItem.toMap());
      print('Item added successfully');
    } catch (e) {
      print('Failed to add item: $e');
    }
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'food_delivery.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT
          )
        ''');

        // Créer d'autres tables ici (restaurants, items, orders, order_details)
      },
      version: 1,
    );
  }
}
