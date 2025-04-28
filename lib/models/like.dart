class Like {
  final String id;
  final String? videoId;
  final String? commentId;
  final String userId;

  Like({
    required this.id,
    this.videoId,
    this.commentId,
    required this.userId,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['_id'] ?? '',
      videoId: json['video'],
      commentId: json['comment'],
      userId: json['user'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'video': videoId,
      'comment': commentId,
      'user': userId,
    };
  }
}
