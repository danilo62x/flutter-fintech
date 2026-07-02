/// Clean domain model for a payment card (physical or virtual).
class PaymentCard {
  const PaymentCard({
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

  /// 'VISA' or 'MASTERCARD'.
  final String brand;

  /// Formatted as MM/YY.
  final String expiry;

  final double limit;
  final double used;
  final bool isVirtual;
  final bool isFrozen;

  double get available {
    final double free = limit - used;
    return free < 0 ? 0 : free;
  }

  double get usedFraction {
    if (limit <= 0) return 0;
    final double f = used / limit;
    if (f < 0) return 0;
    if (f > 1) return 1;
    return f;
  }

  PaymentCard copyWith({bool? isFrozen}) {
    return PaymentCard(
      id: id,
      holder: holder,
      last4: last4,
      brand: brand,
      expiry: expiry,
      limit: limit,
      used: used,
      isVirtual: isVirtual,
      isFrozen: isFrozen ?? this.isFrozen,
    );
  }
}
