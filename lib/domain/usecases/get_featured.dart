import 'package:clean_architecture/data/constants.dart';
import 'package:clean_architecture/data/failures.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class GetFeatured {
  final NewsRepository repository;

  GetFeatured(this.repository);

  Future<Either<Failure, List<NewsObject>>> execute() async {
    print('Fetching news');
    final results = await repository.getNews(kFeaturedUrl);
    print('done fetching');
    return results;
  }
}
