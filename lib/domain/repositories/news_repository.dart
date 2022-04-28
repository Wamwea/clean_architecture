import 'package:clean_architecture/data/failures.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsObject>>> getNews(String newsPath);
}
