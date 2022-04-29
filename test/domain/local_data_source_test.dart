import 'dart:ffi';

import 'package:clean_architecture/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/data/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

class MockHiveBox extends Mock implements Box {}

void main() {
  late MockHiveInterface hive;
  late LocalDataSource source;
  late MockHiveBox box;
  setUp(() async {
    hive = MockHiveInterface();
    source = LocalDataSourceImplementation(database: hive);
    box = MockHiveBox();
    when(hive.openBox(any)).thenAnswer((realInvocation) async => box);
    when(hive.init(any)).thenAnswer((realInvocation) async => box);
  });

  test('init is always called and returns a box', () async {
    when(box.get('darkMode')).thenAnswer((realInvocation) async => dynamic);

    await source.getValue('darkMode');

    verify(source.init()).called(1);
    expect(await source.init(), box);
  });

  test('get value returns a dynamic value when succesfull', () async {
    when(box.get('value')).thenAnswer((realInvocation) => dynamic);

    var result = await source.getValue('value');

    verify(box.get('value')).called(1);
    expect(result, isA<dynamic>());
  });

  test('get value throws an database exception on error', () async {
    when(box.get('value')).thenThrow(Error());

    var result = source.getValue('value');

    expectLater(result, throwsA(isA<DatabaseException>()));
  });
}
