import '../../domain/models/payment_card.dart';

/// API representation of a payment card with MANUAL json mapping.
class PaymentCardApiModel {
  const PaymentCardApiModel({
    required this.id,
    required this.holder,
    required this.last4,
    required this.brand,
    required this.expiry,
    required this.limit,
    required this.used,
    required this.isVirtual,
    required this.isFrozen,
  });

  final String id;
  final String holder;
  final String last4;
  final String brand;
  final String expiry;
  final double limit;
  final double used;
  final bool isVirtual;
  final bool isFrozen;

  factory PaymentCardApiModel.fromJson(Map<String, dynamic> json) {
    return PaymentCardApiModel(
      id: json['id'] as String,
      holder: json['holder'] as String,
      last4: json['last4'] as String,
      brand: json['brand'] as String,
      expiry: json['expiry'] as String,
      limit: (json['limit'] as num).toDouble(),
      used: (json['used'] as num).toDouble(),
      isVirtual: json['isVirtual'] as bool? ?? false,
      isFrozen: json['isFrozen'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'holder': holder,
      'last4': last4,
      'brand': brand,
      'expiry': expiry,
      'limit': limit,
      'used': used,
      'isVirtual': isVirtual,
      'isFrozen': isFrozen,
    };
  }

  PaymentCard toDomain() {
    return PaymentCard(
      id: id,
      holder: holder,
      last4: last4,
      brand: brand,
      expiry: expiry,
      limit: limit,
      used: used,
      isVirtual: isVirtual,
      isFrozen: isFrozen,
    );
  }
}
