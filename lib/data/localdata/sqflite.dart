









import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseVersion = 2;


  
static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  //  يُستخدم عندما تريد التحكم في كيفية إنشاء الكائن أو إرجاع كائن موجود بدلاً من إنشاء كائن جديد factory 
  DatabaseHelper._internal();
  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), "travels.db");
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
      // db.execute('''
      //     CREATE TABLE travelers (
      //       id integer primary key autoincrement,
      //       name TEXT not null,
      //       dob TEXT not null,
      //       gender TEXT,
      //       nationality TEXT,
      //       passportNumber integer not null,
      //       phoneNumber integer not null ,
      //       passportImagePath TEXT not null
      //     )
      //   ''');
        db.execute('''
          CREATE TABLE notifications(
            id integer primary key autoincrement,
            title TEXT,
            body TEXT,
            date TEXT
          )
        ''');
    });
    
  }
  Future<bool> isDuplicate(String name, String passportNumber, String imagePath) async {
    final db = await database;
    final result = await db.query(
      'travelers',
      where: 'name = ? or passportNumber = ? or passportImagePath = ?',
      whereArgs: [name, passportNumber, imagePath],
    );
    return result.isNotEmpty;
  }
  // Future<int> insertdata(Map<String, dynamic> data,String table) async {
  //   final db = await database;
  //    final isDuplicateEntry = await isDuplicate(
  //     data['name'] as String,
  //     data['passportNumber'] as String,
  //     data['passportImagePath'] as String,
  //   );

  //   if (isDuplicateEntry) {
  //     return -1;
  //   }
  //   else
  //   return await db.insert(table, data);
  // }

  Future<int> insertdata(Map<String, dynamic> data,String table) async {
    final db = await database;
    return await db.insert(table,data);
  }

  Future<List<Map<String, dynamic>>> getdata(String table) async {
    final db = await database;
    return await db.query(table);
  }

  
   Future<List<Map<String, dynamic>>>  getOneData(int id,String table) async {
    final db = await database;
    return await db.query(table, where: 'id = ?', whereArgs: [id],limit: 1);
  }

  Future<int> deletedata(int id,String table) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}


// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();

//   factory DatabaseHelper() => _instance;

//   DatabaseHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'passengers.db');

//     return openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute('''
//           CREATE TABLE passengers (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             name TEXT,
//             dob TEXT,
//             gender TEXT,
//             nationality TEXT,
//             passportNumber TEXT,
//             phoneNumber TEXT
//           )
//         ''');
//       },
//     );
//   }

//   Future<int> insertPassenger(Map<String, dynamic> passenger) async {
//     final db = await database;
//     return await db.insert('passengers', passenger);
//   }

//   Future<List<Map<String, dynamic>>> getPassengers() async {
//     final db = await database;
//     return await db.query('passengers');
//   }

//   Future<int> deletePassenger(int id) async {
//     final db = await database;
//     return await db.delete('passengers', where: 'id = ?', whereArgs: [id]);
//   }
// }
