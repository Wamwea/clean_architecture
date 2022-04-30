import 'package:clean_architecture/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/data/failures.dart';
import 'package:clean_architecture/data/models/news_model.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/domain/repositories/local_repository.dart';
import 'package:dartz/dartz.dart';

class LocalRepositoryImplementation extends LocalRepository {
  LocalDataSource dataSource;
  LocalRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, void>> deleteSavedNews(NewsObject article) async {
    try {
      await dataSource.removeValueFromList(
          'saved_news', NewsModel.fromEntity(article).toMap(), 'link');
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure('error deleting news article'));
    }
  }

  @override
  Future<Either<Failure, List<NewsObject>>> getSavedNews() async {
    try {
      List<NewsObject> results = [];
      var hiveObject =
          await dataSource.getValue('saved_news') as List<dynamic>?;
      List<Map<String, dynamic>> list = hiveObject != null
          ? hiveObject.map((e) => Map<String, dynamic>.from(e)).toList()
          : [];
      for (var element in list) {
        results.add(NewsModel.fromMap(element).toEntity());
      }
      return Right(results.isEmpty ? [] : results);
    } catch (e) {
      return const Left(
          DatabaseFailure(' Oops. Something happened with the database'));
    }
  }

  @override
  Future<Either<Failure, bool>> getTheme() async {
    try {
      bool? result = await dataSource.getValue('darkMode');
      if (result == null) await dataSource.setValue('darkMode', true);
      result = await dataSource.getValue('darkMode');
      return Right(result!);
    } catch (e) {
      return const Left(DatabaseFailure(
          'Something happened with database while fetching theme'));
    }
  }

  @override
  Future<void> saveNewsArticle(NewsObject article) async {
    List<NewsObject> results = [];
    var response = await getSavedNews();
    response.fold(
        (l) => throw const DatabaseFailure(
            ' Something happened with the database while fetching saved news'),
        (r) => results = r);
    results.add(article);
    List<Map<String, dynamic>> getAsMap = [];
    for (var result in results) {
      getAsMap.add(NewsModel(
              imageUrl: result.imageUrl,
              title: result.title,
              description: result.description,
              author: result.author,
              pubDate: result.pubDate,
              link: result.link)
          .toMap());
    }
    await dataSource.setValue('saved_news', getAsMap);
  }

  @override
  Future<bool> toggleTheme() async {
    var response = await getTheme();
    bool? theme;
    response.fold(
        (l) => throw const DatabaseFailure('Database error toggling theme'),
        (r) {
      theme = !r;
      dataSource.setValue('darkMode', theme);
    });
    return theme ?? false;
  }
}
