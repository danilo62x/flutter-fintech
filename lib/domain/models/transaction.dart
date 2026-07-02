/// Clean domain model for a wallet transaction.
class Transaction {
  const Transaction({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
    required this.icon,
  });

  final String id;
  final String title;
  final String category;
  final DateTime date;

  /// Positive for income, negative for expense.
  final double amount;

  /// Semantic icon key (mapped to a Material icon in the UI layer).
  final String icon;

  bool get isIncome => amount >= 0;
}
