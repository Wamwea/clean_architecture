import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:dartz/dartz.dart';

import '../../data/failures.dart';

abstract class LocalRepository {
  Future<Either<Failure, List<NewsObject>>> getSavedNews();
  Future<Either<Failure, bool>> getTheme();
  Future<bool> toggleTheme();
  Future<void> deleteSavedNews();
  Future<void> saveNewsArticle(NewsObject article);
}
