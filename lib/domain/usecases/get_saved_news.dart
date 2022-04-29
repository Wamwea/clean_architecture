import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/domain/repositories/local_repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/failures.dart';

class GetSavedNews {
  LocalRepository localRepository;
  GetSavedNews(this.localRepository);

  Future<Either<Failure, List<NewsObject>>> execute() async {
    var result = await localRepository.getSavedNews();

    return result;
  }
}
