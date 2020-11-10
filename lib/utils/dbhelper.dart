import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/list_items.dart';
import '../models/shopping_list.dart';

class DbHelper {
  final int dbVersion = 1;
  Database db;

  Future testDb() async {
    db = await openDb();
    await db.execute('INSERT INTO lists VALUES (0, "Fruit", 2)');
    await db.execute(
        'INSERT INTO items VALUES (0, 0, "Apples","2 Kg","Better if they are green")');
    List lists = await db.rawQuery('select * from lists');
    List items = await db.rawQuery('select * from items');
    print(lists[0].toString());
    print(items[0].toString());
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'shopping.db'),
          onCreate: (db, version) {
        db.execute(
            'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
        db.execute(
            'CREATE TABLE items(id INTEGER PRIMARY KEY,idList INTEGER, name TEXT, quantity TEXT,note TEXT, ' +
                'FOREIGN KEY(idList)REFERENCES lists(id))');
      }, version: dbVersion);
    }
    return db;
  }

  Future<int> insertList(ShoppingList list) async {
    int id = await this.db.insert(
          'lists',
          list.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<int> insertItem(ListItem item) async {
    int id = await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }
}
