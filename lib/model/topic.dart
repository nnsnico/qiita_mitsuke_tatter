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
  final String likesCount;
  final List<String> tags;
  final String updatedAt;
  final User user;
}
