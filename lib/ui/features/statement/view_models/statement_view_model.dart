import 'package:flutter/foundation.dart';

import '../../../../data/repositories/statement_repository.dart';
import '../../../../domain/models/category_spend.dart';
import '../../../../domain/models/transaction.dart';

/// Holds statement state: selected month, category breakdown and line items.
/// Seeds synchronously so the screenshot renders content.
class StatementViewModel extends ChangeNotifier {
  StatementViewModel({StatementRepository? repository})
      : _repository = repository ?? StatementRepository() {
    _categories = _repository.seed();
    _entries = _repository.seedEntries();
    _months = _repository.months;
    _monthIndex = _months.length - 1;
  }

  final StatementRepository _repository;

  List<CategorySpend> _categories = const <CategorySpend>[];
  List<Transaction> _entries = const <Transaction>[];
  List<String> _months = const <String>[];
  int _monthIndex = 0;

  List<CategorySpend> get categories => List.unmodifiable(_categories);
  List<Transaction> get entries => List.unmodifiable(_entries);
  List<String> get months => List.unmodifiable(_months);
  int get monthIndex => _monthIndex;
  String get monthLabel => _months[_monthIndex];

  double get total =>
      _categories.fold<double>(0, (double s, CategorySpend c) => s + c.amount);

  double fractionOf(CategorySpend c) => total <= 0 ? 0 : c.amount / total;

  void selectMonth(int index) {
    if (index < 0 || index >= _months.length) return;
    _monthIndex = index;
    notifyListeners();
  }
}
