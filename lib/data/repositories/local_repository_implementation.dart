import 'package:clean_architecture/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/data/models/news_model.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/domain/repositories/local_repository.dart';

class LocalRepositoryImplementation extends LocalRepository {
  LocalDataSource dataSource;
  LocalRepositoryImplementation(this.dataSource);

  @override
  Future<void> deleteSavedNews() {
    // TODO: implement deleteSavedNews
    throw UnimplementedError();
  }

  @override
  Future<List<NewsObject>> getSavedNews() async {
    List<NewsObject> results = [];
    var hiveObject = await dataSource.getValue('saved_news') as List<dynamic>?;
    List<Map<String, dynamic>> list = hiveObject != null
        ? hiveObject.map((e) => Map<String, dynamic>.from(e)).toList()
        : [];
    for (var element in list) {
      results.add(NewsModel.fromMap(element).toEntity());
    }
    return results.isEmpty ? [] : results;
  }

  @override
  Future<bool> getTheme() async {
    bool? result = await dataSource.getValue('darkMode');
    if (result == null) await dataSource.setValue('darkMode', true);
    result = await dataSource.getValue('darkMode');
    return result!;
  }

  @override
  Future<void> saveNewsArticle(NewsObject article) async {
    List<NewsObject> results = await getSavedNews();
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
    print(' Data has been added to db');
  }

  @override
  Future<bool> toggleTheme() async {
    bool theme = await getTheme();
    theme = !theme;
    dataSource.setValue('darkMode', theme);
    return getTheme();
  }
}
