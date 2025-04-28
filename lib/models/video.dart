class Video {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String ownerId;
  final bool isPublished;
  final DateTime createdAt;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.ownerId,
    required this.isPublished,
    required this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      ownerId: json['owner'] ?? '',
      isPublished: json['isPublished'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'owner': ownerId,
      'isPublished': isPublished,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
