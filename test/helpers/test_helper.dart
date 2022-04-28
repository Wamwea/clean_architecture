import 'package:clean_architecture/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/domain/repositories/news_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';

@GenerateMocks(
  [NewsRepository, RemoteDataSource, Dio],
)
void main() {}
