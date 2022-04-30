import 'package:dartz/dartz.dart';

import '../../data/failures.dart';
import '../entities/news_object.dart';
import '../repositories/local_repository.dart';

class DeleteSavedNews {
  final LocalRepository localRepository;

  DeleteSavedNews(this.localRepository);

  Future<Either<Failure, void>> call(NewsObject article) async {
    try {
      await localRepository.deleteSavedNews(article);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure('error deleting news article'));
    }
  }
}
