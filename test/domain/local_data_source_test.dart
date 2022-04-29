import 'package:clean_architecture/data/data_sources/local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late MockHiveInterface hive;
  late LocalDataSource source;
  setUp(() {
    hive = MockHiveInterface();
    source = LocalDataSourceImplementation(database: hive);
  });
}
