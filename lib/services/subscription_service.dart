import 'package:http/http.dart' as http;
import '../globals/globals.dart';

class SubscriptionService {
  final String baseUrl = Globals.baseUrl;

  Future<http.Response> subscribe(String channelId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/subscriptions/\$channelId');
    final response = await http.post(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }

  Future<http.Response> unsubscribe(String channelId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/subscriptions/\$channelId');
    final response = await http.delete(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }

  Future<http.Response> getSubscriptions(String accessToken) async {
    final uri = Uri.parse('\$baseUrl/subscriptions');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }
}
