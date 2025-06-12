import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'delivery.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'entregas.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE entregas (
            id_entrega INTEGER PRIMARY KEY AUTOINCREMENT,
            nome_destinatario TEXT,
            endereco TEXT,
            descricao TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertDelivery(Delivery delivery) async {
    final dbClient = await db;
    return await dbClient.insert('entregas', delivery.toMap());
  }

  Future<List<Delivery>> getDeliveries() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> result = await dbClient.query('entregas');
    return result.map((e) => Delivery.fromMap(e)).toList();
  }

  Future<int> updateDelivery(Delivery delivery) async {
    final dbClient = await db;
    return await dbClient.update(
      'entregas',
      delivery.toMap(),
      where: 'id_entrega = ?',
      whereArgs: [delivery.id],
    );
  }

  Future<int> deleteDelivery(int id) async {
    final dbClient = await db;
    return await dbClient.delete(
      'entregas',
      where: 'id_entrega = ?',
      whereArgs: [id],
    );
  }
}