import 'dart:async';

import 'package:flutter_project_intellij/models/textModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  //Avoid errors by flutter
  //DatabaseConnection.ensureInitialized();

  //open database, create db if there is not any

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'texts.db'), //database name
      onCreate: (db, version) {
        //SQLITE code to create a table
        return db.execute(
            "CREATE TABLE texts(id INTEGER PRIMARY KEY,title TEXT, article TEXT, colorIndex INTEGER)");
      },
      version: 1,
    );
  }

  //Insert an element(text) into the database

  Future<void> insertTextModel(TextModel textModel) async {
    final Database db = await database();

    await db.insert('texts', textModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  //Return list of TextModels in order to retrieve in the home page.

  Future<List<TextModel>> getTextModels() async {
    Database _db = await database();
    List<Map<String, dynamic>> textModelsMap =
        await _db.query('texts');
    return List.generate(textModelsMap.length, (index) {
      return TextModel(
        id: textModelsMap[index]['id'],
        title: textModelsMap[index]['title'],
        article: textModelsMap[index]['article'],
        colorIndex: textModelsMap[index]['colorIndex'],
      );
    });
  }
}
