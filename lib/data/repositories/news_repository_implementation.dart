import 'dart:io';

import 'package:clean_architecture/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/data/exceptions.dart';
import 'package:clean_architecture/data/models/news_model.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/data/failures.dart';
import 'package:clean_architecture/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:webfeed/domain/rss_feed.dart';

class NewsRepoImplementation implements NewsRepository {
  final RemoteDataSource remoteDataSource;

  NewsRepoImplementation({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NewsObject>>> getNews(newsPath) async {
    List<NewsObject> list = [];
    try {
      RssFeed rssFeed = await remoteDataSource.getNews(newsPath);

      for (var element in rssFeed.items!) {
        NewsModel model = NewsModel.fromRssItem(element);

        list.add(model.toEntity());
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure('Something happened. Please try again'));
    } on InternetException {
      return const Left(ConnectionFailure('Failed to connect to network'));
    }
  }
}
