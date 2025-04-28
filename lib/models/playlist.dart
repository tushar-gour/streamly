class Playlist {
  final String id;
  final String title;
  final String description;
  final String userId;

  Playlist({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      userId: json['user'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'user': userId,
    };
  }
}
