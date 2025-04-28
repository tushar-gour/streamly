class Profile {
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String avatarUrl;
  final String coverImageUrl;
  final String bio;

  Profile({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.coverImageUrl,
    required this.bio,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: json['avatar'] ?? '',
      coverImageUrl: json['coverImage'] ?? '',
      bio: json['bio'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'fullName': fullName,
      'email': email,
      'avatar': avatarUrl,
      'coverImage': coverImageUrl,
      'bio': bio,
    };
  }
}
