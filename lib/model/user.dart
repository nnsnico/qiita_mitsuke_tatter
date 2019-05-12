class User {
  const User(
    this.name,
    this.id,
    this.description,
    this.imageUrl,
  );

  final String name;
  final String id;
  final String description;
  final String imageUrl;

  static User fromJson(dynamic json) {
    final userJson = json['user'];

    return User(
      userJson['name'],
      userJson['id'],
      userJson['description'],
      userJson['profile_image_url'],
    );
  }
}
