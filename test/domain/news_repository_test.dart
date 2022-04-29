import 'package:clean_architecture/data/constants.dart';
import 'package:clean_architecture/data/failures.dart';
import 'package:clean_architecture/data/repositories/news_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architecture/data/exceptions.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late NewsRepoImplementation repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = NewsRepoImplementation(remoteDataSource: mockRemoteDataSource);
  });

  group('get News', () {
    test('When ServerException is detected, a connection failure is expected',
        () async {
      //arrange
      when(mockRemoteDataSource.getNews(kUrl)).thenThrow(ServerException());

      //act
      var result = await repository.getNews(kUrl);

      //assert
      expect(
          result,
          equals(const Left(
              ServerFailure('Something happened. Please try again'))));
    });

    test(
        'When NoInternetException is detected, a connection failure is expected',
        () async {
      //arrange
      when(mockRemoteDataSource.getNews(kUrl)).thenThrow(InternetException());

      //act
      var result = await repository.getNews(kUrl);

      //assert
      expect(
          result,
          equals(
              const Left(ConnectionFailure('Failed to connect to network'))));
    });
  });
}
