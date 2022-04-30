import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../exceptions.dart';

abstract class LocalDataSource {
  Future<Box> init();
  Future<dynamic> getValue(String key);
  Future<void> removeValueFromList(
      String key, dynamic value, String identifier);
  Future<void> setValue(
    String key,
    dynamic value,
  );
}

class LocalDataSourceImplementation implements LocalDataSource {
  HiveInterface database;
  LocalDataSourceImplementation({required this.database});

  @override
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
        log('Value : ${value.toString()} has been set for key $key');
      }
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> removeValueFromList(
      String key, dynamic value, String identifier) async {
    try {
      var box = await init();
      var boxResult = await box.get(key);
      log('RESULE: $boxResult');
      boxResult =
          boxResult.map((value) => Map<String, dynamic>.from(value)).toList();
      log('Results : ${boxResult[0][identifier]}');
      var newList = boxResult
          .where((element) => element[identifier] != value[identifier])
          .toList();
      log('REMOVED  length: ${newList.length}');
      await box.put(key, newList);
      log('Result: ${box.get(key)}');
    } catch (e) {
      log('Error $e');
      throw DatabaseException();
    }
  }
}
