import 'dart:math';

import 'package:receipt_app/models/meal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class LocalService {
  static final LocalService _instance = LocalService._createInstance();
  factory LocalService() => _instance;
  LocalService._createInstance();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'favorite_meals.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $tableName(${MealFields.id} INTEGER PRIMARY KEY, ${MealFields.idMeal} TEXT,  ${MealFields.strMeal} TEXT, ${MealFields.strInstructions} TEXT, ${MealFields.strMealThumb} TEXT, ${MealFields.strCategory} TEXT)');
      },
      version: 1,
    );
  }

  Future insert(Meal meal) async {
    final dbClient = await db;
    await dbClient.insert(tableName, meal.toMap());
    print("Sukses insert");
  }

  Future delete(String idMeal) async {
    final dbClient = await db;
    await dbClient.delete(
      tableName,
      where: '${MealFields.idMeal} = ?',
      whereArgs: [idMeal],
    );
    print("Sukses delete");
  }

  Future<List<Meal>> getAllFavByCategory(String category) async {
    final dbClient = await db;
    final result = await dbClient.query(
      tableName,
      where: '${MealFields.strCategory} = ?',
      whereArgs: [category],
    );
    return result.map((e) => Meal.fromJson(e)).toList();
  }

  Future<Meal> getFavoriteMeal(String idMeal) async {
    final dbClient = await db;
    final result = await dbClient.query(
      tableName,
      where: '${MealFields.idMeal} = ?',
      whereArgs: [idMeal],
    );
    return Meal.fromJson(result.first);
  }

  Future<bool> isFavorited(String idMeal) async {
    final dbClient = await db;
    final result = await dbClient.query(
      tableName,
      where: '${MealFields.idMeal} = ?',
      whereArgs: [idMeal],
    );
    return result.isNotEmpty;
  }
}
