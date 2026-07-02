import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/payment_card_api_model.dart';

/// Talks to a REST endpoint using package:http (demonstrates the http skill).
class CardApiService {
  CardApiService({http.Client? client, Uri? endpoint})
      : _client = client ?? http.Client(),
        _endpoint =
            endpoint ?? Uri.parse('https://jsonplaceholder.typicode.com/posts');

  final http.Client _client;
  final Uri _endpoint;

  /// Performs a GET request and decodes the card list.
  ///
  /// The demo endpoint does not return real cards, so any decode issue falls
  /// back to an empty list; the repository provides the seed content.
  Future<List<PaymentCardApiModel>> fetchCards() async {
    final response = await _client.get(_endpoint);
    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar cartoes: ${response.statusCode}');
    }
    final decoded = json.decode(response.body);
    if (decoded is! List) {
      return const <PaymentCardApiModel>[];
    }
    return decoded
        .whereType<Map<String, dynamic>>()
        .where((Map<String, dynamic> e) => e.containsKey('last4'))
        .map(PaymentCardApiModel.fromJson)
        .toList();
  }
}
