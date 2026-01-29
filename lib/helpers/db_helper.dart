import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static const String tableName = 'user_transactions';
  static const String todoTable = 'user_todos';
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'expenses.db'),
      onCreate: (db, version) async {
        // Tạo bảng giao dịch
        await db.execute('CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, amount REAL, date TEXT)');
        // Tạo bảng công việc (Todo)
        await db.execute('CREATE TABLE $todoTable(id INTEGER PRIMARY KEY, title TEXT, note TEXT, startAt TEXT, dueDate TEXT, isCompleted INTEGER, priority INTEGER, createdAt TEXT)');
      },
      // Tăng version lên 2 để hệ thống biết cần cập nhật nếu user đã cài bản cũ
      version: 2,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Nếu user đang dùng bản 1, thêm bảng todo vào cho họ
          await db.execute('CREATE TABLE $todoTable(id TEXT PRIMARY KEY, title TEXT, note TEXT, dueDate TEXT, isCompleted INTEGER, priority INTEGER)');
        }
      },
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> delete(String table, int id) async {
    final db = await DBHelper.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> update(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    await db.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }
}
