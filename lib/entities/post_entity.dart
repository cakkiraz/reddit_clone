import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? linkFlairText;
  final int? score;
  const PostEntity(
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.linkFlairText,
    this.score,
  );

  @override
  List<Object> get props => [
        id!,
        title!,
        description!,
        thumbnail!,
        linkFlairText!,
        score!,
      ];

  static PostEntity fromJson(json) {
    return PostEntity(
      json["id"] as String,
      json["title"] as String,
      json["selftext"] as String,
      json["thumbnail"] as String,
      json["link_flair_text"] as String,
      json["score"] as int,
    );
  }
}
