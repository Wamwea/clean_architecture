import 'package:clean_architecture/data/constants.dart';
import 'package:clean_architecture/data/failures.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';

import 'package:clean_architecture/domain/usecases/get_featured.dart';
import 'package:clean_architecture/domain/usecases/get_news.dart';
import 'package:clean_architecture/domain/usecases/get_saved_news.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late MockLocalRepository mockLocalRepository;
  late MockNewsRepository mockNewsRepository;
  late GetNews getNews;
  late GetFeatured getFeatured;

  late GetSavedNews getSaved;
  setUp(() {
    mockNewsRepository = MockNewsRepository();
    getNews = GetNews(mockNewsRepository);
    getFeatured = GetFeatured(mockNewsRepository);
    mockLocalRepository = MockLocalRepository();
    getSaved = GetSavedNews(mockLocalRepository);
  });

  final kDummyList = [
    NewsObject(
        title: '',
        description: '',
        author: '',
        pubDate: DateTime.now(),
        link: '',
        imageUrl: '')
  ];
  group('usecases', () {
    test('if succesful should retrieve a list of NewsObject for getNews',
        () async {
      //arrange
      when(mockNewsRepository.getNews(kUrl))
          .thenAnswer((realInvocation) async => Right(kDummyList));

      //act
      var result = await getNews.execute();

      //asset
      verify(mockNewsRepository.getNews(kUrl)).called(1);
      expect(result, isA<Right<dynamic, List<NewsObject>>>());
      expect(result, equals(Right(kDummyList)));
    });

    test('should retrieve a list of NewsObject for getFeatured', () async {
      //arrange
      when(mockNewsRepository.getNews(kFeaturedUrl))
          .thenAnswer((realInvocation) async => Right(kDummyList));

      //act
      var result = await getFeatured.execute();

      //asset
      verify(mockNewsRepository.getNews(kFeaturedUrl)).called(1);
      expect(result, isA<Right<dynamic, List<NewsObject>>>());
      expect(result, equals(Right(kDummyList)));
    });

    test('should return a failure message if anything goes wrong', () async {
      //arrange
      when(mockNewsRepository.getNews(kUrl)).thenAnswer(
          (realInvocation) async =>
              const Left(ConnectionFailure('unable to connect')));

      //act
      var result = await getNews.execute();

      //asset
      verify(mockNewsRepository.getNews(kUrl)).called(1);
      expect(result, isA<Left>());
      expect(
          result, equals(const Left(ConnectionFailure('unable to connect'))));
    });
    test('should retrieve a list of NewsObject for getSavedNews', () async {
      //arrange
      when(mockLocalRepository.getSavedNews())
          .thenAnswer((_) async => Right(kDummyList));

      //act
      var result = await getSaved.execute();

      //assert

      verify(mockLocalRepository.getSavedNews()).called(1);
      expect(result, isA<Right<dynamic, List<NewsObject>>>());
      expect(result, equals(Right(kDummyList)));
    });
  });
}
