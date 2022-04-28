import 'package:clean_architecture/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/data/repositories/local_repository_implementation.dart';
import 'package:clean_architecture/domain/repositories/local_repository.dart';
import 'package:clean_architecture/domain/repositories/news_repository.dart';
import 'package:clean_architecture/domain/usecases/get_featured.dart';
import 'package:clean_architecture/domain/usecases/get_news.dart';
import 'package:clean_architecture/domain/usecases/get_saved_news.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'data/repositories/news_repository_implementation.dart';

final locator = GetIt.instance;

void init() {
  //client
  locator.registerLazySingleton<HiveInterface>(() => Hive);
  locator.registerLazySingleton<Dio>(() => Dio());

  //data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementation(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImplementation(database: locator()),
  );

  //repository
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepoImplementation(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<LocalRepository>(
    () => LocalRepositoryImplementation(locator()),
  );

  //usecase
  locator.registerLazySingleton<GetNews>(() => GetNews(locator()));
  locator.registerLazySingleton<GetFeatured>(() => GetFeatured(locator()));
  locator.registerLazySingleton<GetSavedNews>(() => GetSavedNews(locator()));
}
