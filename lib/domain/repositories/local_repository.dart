import 'package:clean_architecture/domain/entities/news_object.dart';

abstract class LocalRepository {
  Future<List<NewsObject>> getSavedNews();
  Future<bool> getTheme();
  Future<bool> toggleTheme();
  Future<void> deleteSavedNews();
  Future<void> saveNewsArticle(NewsObject article);
}
