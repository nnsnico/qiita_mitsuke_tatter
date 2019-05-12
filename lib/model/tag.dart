class Tag {
  Tag(this.name);

  String name;

  static Tag fromJson(dynamic json) => Tag(json['name']);

  static List<Tag> getTagListFromJson(dynamic json) {
    final tagsJson = json['tags'];
    var tags = List<Tag>();
    for (var tag in tagsJson) {
      tags.add(Tag.fromJson(tag));
    }
    return tags;
  }
}
