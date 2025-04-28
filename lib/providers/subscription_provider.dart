import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../services/subscription_service.dart';
import 'dart:convert';

class SubscriptionProvider with ChangeNotifier {
  List<Subscription> _subscriptions = [];
  bool _isLoading = false;
  final SubscriptionService _subscriptionService = SubscriptionService();

  List<Subscription> get subscriptions => _subscriptions;
  bool get isLoading => _isLoading;

  Future<void> fetchSubscriptions(String accessToken) async {
    _isLoading = true;
    notifyListeners();

    final response = await _subscriptionService.getSubscriptions(accessToken);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> subsJson = data['data'];
      _subscriptions = subsJson.map((json) => Subscription.fromJson(json)).toList();
    } else {
      _subscriptions = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> subscribe(String channelId, String accessToken) async {
    final response = await _subscriptionService.subscribe(channelId, accessToken);
    if (response.statusCode == 200 || response.statusCode == 201) {
      await fetchSubscriptions(accessToken);
      return true;
    }
    return false;
  }

  Future<bool> unsubscribe(String channelId, String accessToken) async {
    final response = await _subscriptionService.unsubscribe(channelId, accessToken);
    if (response.statusCode == 200) {
      await fetchSubscriptions(accessToken);
      return true;
    }
    return false;
  }
}
