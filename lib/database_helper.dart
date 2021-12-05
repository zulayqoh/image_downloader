import 'dart:io';
import 'package:image_downloader/image_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // if database doesn't exist initialise the database, else return the database that exist
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'pictures.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE pictures(
    id INTEGER PRIMARY KEY,
    name TEXT
    )
    ''');
  }

  Future<List<Picture>> getPictures() async {
    Database db = await instance.database;
    var pictures = await db.query('pictures', orderBy: 'name');
    List<Picture> imageList = pictures.isNotEmpty
        ? pictures.map((c) => Picture.fromMap(c)).toList()
        : [];
    return imageList;
  }
  void savePicture(Picture picture) async {
    Database db = await instance.database;
    await db.insert("Picture", picture.toMap());
  }
  Future<int> add(Picture picture) async {
    Database db = await instance.database;
    return await db.insert('pictures', picture.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('pictures', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Picture picture) async {
    Database db = await instance.database;
    return await db.update('pictures', picture.toMap(), where: 'id = ?', whereArgs: [picture.id]);
  }

}


