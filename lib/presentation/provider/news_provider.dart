import 'package:clean_architecture/data/failures.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/domain/usecases/get_featured.dart';
import 'package:clean_architecture/domain/usecases/get_news.dart';
import 'package:clean_architecture/injector.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_saved_news.dart';

FutureProvider<Either<Failure, List<NewsObject>>> newsProvider =
    FutureProvider((ref) async {
  return await locator<GetNews>().execute();
});

FutureProvider<Either<Failure, List<NewsObject>>> featuredNewsProvider =
    FutureProvider((ref) async {
  return await locator<GetFeatured>().execute();
});

StreamProvider<Either<Failure, List<NewsObject>>> savedNewsProvider =
    StreamProvider(
        (ref) => Stream.periodic(const Duration(seconds: 1), (count) {
              return locator<GetSavedNews>().execute();
            }).asyncMap((event) async => await event));
