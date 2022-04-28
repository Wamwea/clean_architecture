import 'package:clean_architecture/data/constants.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/domain/usecases/get_featured.dart';
import 'package:clean_architecture/domain/usecases/get_news.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late MockNewsRepository mockNewsRepository;
  late GetNews usecase;
  late GetFeatured usecase2;
  setUp(() {
    mockNewsRepository = MockNewsRepository();
    usecase = GetNews(mockNewsRepository);
    usecase2 = GetFeatured(mockNewsRepository);
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
    test('should retrieve a list of NewsObject for getNews', () async {
      //arrange
      when(mockNewsRepository.getNews(kUrl))
          .thenAnswer((realInvocation) async => Right(kDummyList));

      //act
      var result = await usecase.execute();

      //asset
      verify(mockNewsRepository.getNews(kUrl)).called(1);
      expect(result, isA<Right<dynamic, List<NewsObject>>>());
      expect(result, equals(Right(kDummyList)));
    });
  });
}
