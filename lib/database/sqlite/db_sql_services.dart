import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:qr_lite/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBservice{

  static Database? _database;

  static final DBservice db = DBservice._();

  DBservice._();

  Future<Database?> get database async  {

    if (_database != null ) return _database;

    _database = await initDB();

    return _database;

  }

  Future<Database> initDB() async{

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, "ScansDB.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
        ''');
      },
    );

  }


  Future<int> newScan(ScanModel scanModel)async {

    final db = await database;

    final res = await db!.insert("Scans", scanModel.toJsonMap());

    return res;

  }

  Future<List<ScanModel>> getAllScans()async{

    final db = await database;

    final res = await db!.query("Scans");

    final List<ScanModel> scans = 
      res.map((e) => ScanModel.fromJsonMap(e)).toList();

    return scans;

  }

  Future<int> deleteScan(int id)async{

    final db = await database;

    final res = await db!.delete("Scans", where: "id = ?", whereArgs: [id] );

    return res;

  }

  

}