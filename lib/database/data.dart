import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:doan/model/nhanvien.dart';

class DSNhanVien {
  static final DSNhanVien instance = DSNhanVien._init();
  static Database? _database;

  DSNhanVien._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('nhanvien.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE nhanvien (
        manhanvien TEXT UNIQUE PRIMARY KEY,
        tennhanvien TEXT,
        email TEXT,
        sdt TEXT,
        chucvu TEXT,
      )
    ''');
  }

  Future<int> insertNhanVien(NhanVien nhanvien) async {
    final db = await database;
    return await db.insert(
      'nhanvien',
      nhanvien.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort, 
  );
}

  Future<List<NhanVien>> getNhanvien() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('nhanvien');
    return List.generate(maps.length, (i) => NhanVien.fromMap(maps[i]));
  }

  Future<int> updateNhanVien(NhanVien nhanvien) async {
    final db = await database;
    return await db.update(
      'nhanvien',
      nhanvien.toMap(),
      where: "manhanvien = ?",
      whereArgs: [nhanvien.manhanvien],
    );
  }

  Future<int> deleteNhanVien(String manhanvien) async {
    final db = await database;
    return await db.delete(
      'nhanvien',
      where: "manhanvien = ?",
      whereArgs: [manhanvien],
    );
  }
}
