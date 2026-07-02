import '../../domain/models/transaction.dart';

/// API representation of a transaction with MANUAL json mapping.
class TransactionApiModel {
  const TransactionApiModel({
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
  final String date;
  final double amount;
  final String icon;

  factory TransactionApiModel.fromJson(Map<String, dynamic> json) {
    return TransactionApiModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'category': category,
      'date': date,
      'amount': amount,
      'icon': icon,
    };
  }

  Transaction toDomain() {
    return Transaction(
      id: id,
      title: title,
      category: category,
      date: DateTime.tryParse(date) ?? DateTime.now(),
      amount: amount,
      icon: icon,
    );
  }
}
