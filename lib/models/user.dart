class User {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String avatar;
  final String coverImage;

  User({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.avatar,
    required this.coverImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      coverImage: json['coverImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'username': username,
      'email': email,
      'avatar': avatar,
      'coverImage': coverImage,
    };
  }
}
