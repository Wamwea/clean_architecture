import 'dart:developer';

import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:hive/hive.dart';

abstract class LocalDataSource {
  Future<dynamic> getValue(String key);
  Future<void> updateValue(String key, dynamic value);
  Future<void> setValue(String key, dynamic value);
}

class LocalDataSourceImplementation implements LocalDataSource {
  HiveInterface database;
  LocalDataSourceImplementation({required this.database});

  Future<Box> init() async {
    return await Hive.openBox('database');
  }

  @override
  Future<dynamic> getValue(String key) async {
    var box = await init();
    return box.get(key);
  }

  @override
  Future<void> setValue(String key, dynamic value) async {
    var box = await init();
    try {
      await box.put(key, value);
    } catch (e) {
      log(e.toString());
    }
    print('Value : ${value.toString()} has been set for key $key');
  }

  @override
  Future<void> updateValue(String key, value) {
    // TODO: implement updateValue
    throw UnimplementedError();
  }
}
