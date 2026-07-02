import 'package:flutter/foundation.dart';

import '../../../../data/repositories/wallet_repository.dart';
import '../../../../domain/models/transaction.dart';

/// Holds wallet state. Seeds synchronously in the constructor so the first
/// frame (and the screenshot test) already renders content.
class WalletViewModel extends ChangeNotifier {
  WalletViewModel({WalletRepository? repository})
      : _repository = repository ?? WalletRepository() {
    _transactions = _repository.seed();
  }

  final WalletRepository _repository;

  List<Transaction> _transactions = const <Transaction>[];
  bool _isLoading = false;

  // Static account details for the demo wallet.
  final String userName = 'Ana';
  final String userInitials = 'AS';
  final double balance = 12480.55;
  final String cardNumber = '4321';

  List<Transaction> get transactions => List.unmodifiable(_transactions);
  bool get isLoading => _isLoading;

  double get income => _transactions
      .where((t) => t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);

  double get expenses => _transactions
      .where((t) => !t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);

  /// Real async refresh through the repository/service.
  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();
    try {
      _transactions = await _repository.fetch();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
