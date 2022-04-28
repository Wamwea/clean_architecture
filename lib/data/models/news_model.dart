// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:webfeed/domain/rss_item.dart';

class NewsModel {
  final String title;
  final String description;
  final String author;
  final DateTime pubDate;
  final String link;
  final String? imageUrl;
  NewsModel({
    required this.title,
    required this.description,
    required this.author,
    required this.pubDate,
    required this.link,
    this.imageUrl,
  });

  static String getDomain(String url) {
    if (!url.contains('www.')) {
      url = 'https://www.' + url.substring(url.indexOf('/') + 2);
    }
    url = url.substring(url.indexOf('.')).split('.')[1];
    return url;
  }

  NewsModel copyWith({
    String? title,
    String? description,
    String? author,
    DateTime? pubDate,
    String? link,
    String? imageUrl,
  }) {
    return NewsModel(
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      pubDate: pubDate ?? this.pubDate,
      link: link ?? this.link,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory NewsModel.fromRssItem(RssItem element) => NewsModel(
      title: element.title ?? 'Unavailable',
      description: element.description ?? '',
      author: element.author ?? getDomain(element.link!),
      pubDate: element.pubDate ?? DateTime.now(),
      link: element.link ?? 'unavailable',
      imageUrl: element.media == null
          ? element.content!.images.first
          : element.media!.thumbnails == null
              ? element.media!.contents!.first.url
              : element.media!.thumbnails!.isNotEmpty
                  ? element.media!.thumbnails!.first.url
                  : null);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'author': author,
      'pubDate': pubDate.millisecondsSinceEpoch,
      'link': link,
      'imageUrl': imageUrl,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      title: map['title'] as String,
      description: map['description'] as String,
      author: map['author'] as String,
      pubDate: DateTime.fromMillisecondsSinceEpoch(map['pubDate'] as int),
      link: map['link'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsModel(title: $title, description: $description, author: $author, pubDate: $pubDate, link: $link, imageUrl: $imageUrl)';
  }

  NewsObject toEntity() => NewsObject(
      title: title,
      description: description,
      author: author,
      pubDate: pubDate,
      link: link,
      imageUrl: imageUrl);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModel &&
        other.title == title &&
        other.description == description &&
        other.author == author &&
        other.pubDate == pubDate &&
        other.link == link &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        author.hashCode ^
        pubDate.hashCode ^
        link.hashCode ^
        imageUrl.hashCode;
  }
}
