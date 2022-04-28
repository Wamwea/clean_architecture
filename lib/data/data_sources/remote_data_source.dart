import 'dart:developer';

import 'package:clean_architecture/data/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:webfeed/webfeed.dart';

abstract class RemoteDataSource {
  Future<RssFeed> getNews(String newsPath);
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  Dio client;
  RemoteDataSourceImplementation({required this.client});

  @override
  Future<RssFeed> getNews(
    newsPath,
  ) async {
    try {
      final Response response = await client.get(newsPath);
      if (response.statusCode == 200) {
        var feed = RssFeed.parse(response.data.toString());
        return feed;
      } else {
        throw ServerException();
      }
    } on DioError {
      throw InternetException();
    }
  }
}
