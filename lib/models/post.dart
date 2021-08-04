import 'package:meta/meta.dart';
import 'package:reddit_clone/entities/post_entity.dart';

@immutable
class Post {
  String? id;
  String? title;
  String? description;
  String? thumbnail;
  String? linkFlairText;
  int? score;

  Post(
      {this.title,
      this.description,
      this.thumbnail,
      this.linkFlairText,
      this.score,
      String? id})
      : this.id = id;

  Post copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnail,
    String? linkFlairText,
    int? score,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      linkFlairText: linkFlairText ?? this.linkFlairText,
      score: score ?? this.score,
    );
  }

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      thumbnail.hashCode ^
      linkFlairText.hashCode ^
      score.hashCode ^
      id.hashCode;

  @override
  bool operator ==(
          Object other) => // BU COK ONEMLI. BURAYA HER DEGISKENI EKLEMELISIN
      identical(this, other) || // BU SAYEDE GUNCELLEMELER GELIYOR.
      other is Post &&
          runtimeType == other.runtimeType &&
          thumbnail == other.thumbnail &&
          title == other.title &&
          description == other.description &&
          linkFlairText == other.linkFlairText &&
          id == other.id;

  PostEntity toEntity() {
    return PostEntity(
      id!,
      title ?? '',
      description ?? '',
      thumbnail ?? '',
      linkFlairText ?? '',
      score!,
    );
  }

  static Post fromEntity(PostEntity entity) {
    return Post(
      id: entity.id,
      title: entity.title ?? '',
      description: entity.description ?? '',
      thumbnail: entity.thumbnail ?? '',
      score: entity.score ?? 0,
      linkFlairText: entity.linkFlairText ?? '',
    );
  }
}
