import 'package:flutter/foundation.dart';

import '../../../../data/repositories/card_repository.dart';
import '../../../../domain/models/payment_card.dart';
import '../../../../domain/models/transaction.dart';

/// Holds card detail state (active card, invoice, freeze toggle). Seeds
/// synchronously in the constructor so the screenshot renders content.
class CardViewModel extends ChangeNotifier {
  CardViewModel({CardRepository? repository})
      : _repository = repository ?? CardRepository() {
    _cards = _repository.seed();
    _invoice = _repository.seedInvoice();
  }

  final CardRepository _repository;

  List<PaymentCard> _cards = const <PaymentCard>[];
  List<Transaction> _invoice = const <Transaction>[];
  int _activeIndex = 0;

  final String closingDate = '05/07';
  final String dueDate = '12/07';

  List<PaymentCard> get cards => List.unmodifiable(_cards);
  List<Transaction> get invoice => List.unmodifiable(_invoice);
  PaymentCard get active => _cards[_activeIndex];
  int get activeIndex => _activeIndex;

  double get invoiceTotal =>
      _invoice.fold<double>(0, (double s, Transaction t) => s + t.amount.abs());

  void selectCard(int index) {
    if (index < 0 || index >= _cards.length) return;
    _activeIndex = index;
    notifyListeners();
  }

  void toggleFreeze() {
    final PaymentCard current = _cards[_activeIndex];
    _cards = List<PaymentCard>.from(_cards);
    _cards[_activeIndex] = current.copyWith(isFrozen: !current.isFrozen);
    notifyListeners();
  }
}
