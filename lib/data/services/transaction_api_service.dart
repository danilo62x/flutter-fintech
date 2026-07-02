import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/transaction_api_model.dart';

/// Talks to a REST endpoint using package:http (demonstrates the http skill).
class TransactionApiService {
  TransactionApiService({http.Client? client, Uri? endpoint})
      : _client = client ?? http.Client(),
        _endpoint = endpoint ??
            Uri.parse('https://jsonplaceholder.typicode.com/posts');

  final http.Client _client;
  final Uri _endpoint;

  /// Performs a GET request and decodes the transaction list.
  ///
  /// The demo endpoint does not return real transactions, so any decode issue
  /// falls back to an empty list; the repository provides the seed content.
  Future<List<TransactionApiModel>> fetchTransactions() async {
    final response = await _client.get(_endpoint);
    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar transacoes: ${response.statusCode}');
    }
    final decoded = json.decode(response.body);
    if (decoded is! List) {
      return const <TransactionApiModel>[];
    }
    return decoded
        .whereType<Map<String, dynamic>>()
        .where((Map<String, dynamic> e) => e.containsKey('icon'))
        .map(TransactionApiModel.fromJson)
        .toList();
  }
}
