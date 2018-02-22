import 'package:qiita_mitsuke_tatter/model/tag.dart';
import 'package:qiita_mitsuke_tatter/model/user.dart';

class Topic {
  const Topic(
      this.title,
      this.body,
      this.likesCount,
      this.tags,
      this.updatedAt,
      this.user);

  final String title;
  final String body;
  final int likesCount;
  final List<Tag> tags;
  final String updatedAt;
  final User user;
}
