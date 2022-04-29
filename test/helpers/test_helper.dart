import 'package:clean_architecture/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/domain/repositories/local_repository.dart';
import 'package:clean_architecture/domain/repositories/news_repository.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';

@GenerateMocks(
  [
    NewsRepository,
    RemoteDataSource,
    Dio,
    LocalDataSource,
    HiveInterface,
    LocalRepository
  ],
)
void main() {}
