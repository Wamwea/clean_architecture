import 'dart:io';

import 'package:clean_architecture/data/constants.dart';
import 'package:clean_architecture/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/data/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter client;
  late RemoteDataSource dataSource;
  late String mockXmlResponse;

  setUp(() async {
    final dio = Dio();
    dataSource = RemoteDataSourceImplementation(client: dio);
    client = DioAdapter(dio: dio);
    File file = File('test/helpers/mockRssResponse.xml');
    mockXmlResponse = await file.readAsString();
  });

  group('remote data source', () {
    test('remote data source returns an RssFeed object for getNews', () async {
      //arrange
      client.onGet(kUrl, (server) => server.reply(200, mockXmlResponse));

      //act
      var result = await dataSource.getNews(kUrl);

      //assert
      expect(result, isA<RssFeed>());
    });

    test(
        'should throw am Internet exception when response code is 404 or other',
        () {
      //arrange
      client.onGet(
          kUrl,
          (server) => server.throws(
              500, DioError(requestOptions: RequestOptions(path: ''))));

      //act
      var result = dataSource.getNews(kUrl);

      //assert
      expect(() => result, throwsA(isA<InternetException>()));
    });
  });
}
