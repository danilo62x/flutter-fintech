import 'package:flutter/foundation.dart';

import '../../../../data/repositories/wallet_repository.dart';
import '../../../../domain/models/transaction.dart';

enum TransactionFilter { all, income, expense }

/// Holds the full transaction history with search + filter state. Seeds
/// synchronously in the constructor so the screenshot renders content.
class TransactionsViewModel extends ChangeNotifier {
  TransactionsViewModel({WalletRepository? repository})
      : _repository = repository ?? WalletRepository() {
    _all = _repository.seedAll();
  }

  final WalletRepository _repository;

  List<Transaction> _all = const <Transaction>[];
  TransactionFilter _filter = TransactionFilter.all;
  String _query = '';

  TransactionFilter get filter => _filter;
  String get query => _query;

  void setFilter(TransactionFilter value) {
    _filter = value;
    notifyListeners();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  List<Transaction> get _filtered {
    return _all.where((Transaction t) {
      final bool matchFilter = switch (_filter) {
        TransactionFilter.all => true,
        TransactionFilter.income => t.isIncome,
        TransactionFilter.expense => !t.isIncome,
      };
      final bool matchQuery = _query.isEmpty ||
          t.title.toLowerCase().contains(_query.toLowerCase()) ||
          t.category.toLowerCase().contains(_query.toLowerCase());
      return matchFilter && matchQuery;
    }).toList();
  }

  /// Transactions grouped by day, ordered most-recent first, keyed by a label.
  Map<String, List<Transaction>> get grouped {
    final Map<String, List<Transaction>> out = <String, List<Transaction>>{};
    for (final Transaction t in _filtered) {
      out.putIfAbsent(dayLabel(t.date), () => <Transaction>[]).add(t);
    }
    return out;
  }

  int get count => _filtered.length;

  static String dayLabel(DateTime date) {
    final DateTime today = DateTime(2026, 6, 30);
    final DateTime day = DateTime(date.year, date.month, date.day);
    final int diff = today.difference(day).inDays;
    if (diff == 0) return 'Hoje';
    if (diff == 1) return 'Ontem';
    const List<String> months = <String>[
      'jan', 'fev', 'mar', 'abr', 'mai', 'jun',
      'jul', 'ago', 'set', 'out', 'nov', 'dez',
    ];
    return '${day.day} de ${months[day.month - 1]}';
  }
}
