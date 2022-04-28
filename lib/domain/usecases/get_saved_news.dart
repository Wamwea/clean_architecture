import 'package:clean_architecture/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/domain/repositories/local_repository.dart';

class GetSavedNews {
  LocalRepository localRepository;
  GetSavedNews(this.localRepository);

  Future<List<NewsObject>> execute() async {
    var result = await localRepository.getSavedNews();

    return result;
  }
}
