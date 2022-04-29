import 'dart:developer';

import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../exceptions.dart';

abstract class LocalDataSource {
  Future<Box> init();
  Future<dynamic> getValue(String key);
  Future<void> updateValue(String key, dynamic value);
  Future<void> setValue(String key, dynamic value);
}

class LocalDataSourceImplementation implements LocalDataSource {
  HiveInterface database;
  LocalDataSourceImplementation({required this.database});

  Future<Box> init() async {
    var box = await database.openBox('database');
    return box;
  }

  @override
  Future<dynamic> getValue(String key) async {
    try {
      var box = await init();
      var result = box.get(key);
      return result;
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> setValue(String key, dynamic value) async {
    var box = await init();
    try {
      await box.put(key, value);
      if (kDebugMode) {
        print('Value : ${value.toString()} has been set for key $key');
      }
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> updateValue(String key, value) {
    // TODO: implement updateValue
    throw UnimplementedError();
  }
}
