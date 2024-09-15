// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  // Private constructor
  DatabaseHelper._internal();

  // Public factory method to provide access to the singleton instance
  factory DatabaseHelper() {
    return instance;
  }

  // Method to get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database is null, initialize it
    _database = await _initDatabase();
    return _database!;
  }

  // Method to initialize the database
  Future<Database> _initDatabase() async {
    // Get the path to the database file
    String databasePath = await getDatabasesPath(); // /x/y/z
    String path =
        join(databasePath, 'digital_khata.db'); // /x/y/z/digital_khata.db

    // Open the database
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Method to create the database schema
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS UserCredData (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        gender INTEGER, 
        marriage_status INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Customer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        gender INTEGER, 
        marriage_status INTEGER, 
        mobile TEXT,
        city_id INTEGER,
        state_id INTEGER,
        country_id INTEGER,
        dob TEXT,
        status INTEGER
      )
    ''');
  }

  // CRUD methods
  Future<int> insert(String table, Map<String, dynamic> values) async {
    Database db = await database;
    return await db.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await database;
    return await db.query(table);
  }

  // Query a specific row by id
  Future<Map<String, dynamic>?> queryRowById(String table, int id) async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(table, where: 'id = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  // Query a specific row by multiple clause
  Future<List<Map<String, dynamic>>?> queryRowByClause(
      String table, String whereClause, List<dynamic> whereArgs) async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(table, where: whereClause, whereArgs: whereArgs);
    return results;
  }

  Future<int> update(String table, Map<String, dynamic> values,
      String whereClause, List<dynamic> whereArgs) async {
    Database db = await database;
    return await db.update(table, values,
        where: whereClause, whereArgs: whereArgs);
  }

  Future<int> delete(
      String table, String whereClause, List<dynamic> whereArgs) async {
    Database db = await database;
    return await db.delete(table, where: whereClause, whereArgs: whereArgs);
  }
}
