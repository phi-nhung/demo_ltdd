import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  // Getter để lấy đối tượng database
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  // Khởi tạo DB và copy từ assets nếu chưa có
  static Future<Database> _initDB() async {
    const String dbName = 'doan.db';
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    // Kiểm tra DB đã tồn tại chưa, nếu chưa thì copy từ assets
    if (!await File(path).exists()) {
      print("➡ Copy database from assets to: $path");
      try {
        ByteData data = await rootBundle.load('assets/$dbName');
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        print( "Lỗi copy DB từ assets: $e");
      }
    }

    return await openDatabase(path,
      version: 2,  // tăng version lên 2 để trigger onUpgrade
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          // Thêm cột GIO nếu version cũ là 1
          await db.execute("ALTER TABLE HOADON ADD COLUMN GIO TEXT");
          print("Đã thêm cột GIO vào bảng HOADON");
        }
      },
    );
  }

  static Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<Object?>? arguments]) async {
  final db = await database;
  return await db.rawQuery(sql, arguments);
}

  static Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  static Future<int> update(String table, int id, Map<String, dynamic> data, {String idColumn = 'id'}) async {
    final db = await database;
    return await db.update(table, data, where: '$idColumn = ?', whereArgs: [id]);
  }

  static Future<int> delete(String table, int id, {String idColumn = 'id'}) async {
    final db = await database;
    return await db.delete(table, where: '$idColumn = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  static Future<Map<String, dynamic>?> getById(String table, int id, {String idColumn = 'id'}) async {
    final db = await database;
    final result = await db.query(table, where: '$idColumn = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }
}
