// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class NewsObject extends Equatable {
  final String title;
  final String description;
  final String author;
  final DateTime pubDate;
  final String link;
  final String? imageUrl;

  const NewsObject({
    required this.title,
    required this.description,
    required this.author,
    required this.pubDate,
    required this.link,
    this.imageUrl,
  });

  @override
  List<Object> get props {
    return [
      title,
      description,
      author,
      pubDate,
      link,
    ];
  }
}
