class Subscription {
  final String id;
  final String channelId;
  final String userId;

  Subscription({
    required this.id,
    required this.channelId,
    required this.userId,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['_id'] ?? '',
      channelId: json['channel'] ?? '',
      userId: json['user'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'channel': channelId,
      'user': userId,
    };
  }
}
