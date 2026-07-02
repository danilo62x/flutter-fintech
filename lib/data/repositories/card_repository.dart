import '../../domain/models/payment_card.dart';
import '../../domain/models/transaction.dart';
import '../services/card_api_service.dart';

/// Provides card data: a synchronous [seed] for instant UI content and an
/// asynchronous [fetch] that goes through the real API service.
class CardRepository {
  CardRepository({CardApiService? service})
      : _service = service ?? CardApiService();

  final CardApiService _service;

  /// Synchronous seed so the first frame already has content.
  List<PaymentCard> seed() {
    return const <PaymentCard>[
      PaymentCard(
        id: 'c1',
        holder: 'ANA SOUZA',
        last4: '4321',
        brand: 'VISA',
        expiry: '09/29',
        limit: 12000.00,
        used: 4820.35,
        isVirtual: false,
        isFrozen: false,
      ),
      PaymentCard(
        id: 'c2',
        holder: 'ANA SOUZA',
        last4: '8876',
        brand: 'MASTERCARD',
        expiry: '04/28',
        limit: 5000.00,
        used: 1240.00,
        isVirtual: true,
        isFrozen: false,
      ),
    ];
  }

  /// Recent charges that compose the current invoice.
  List<Transaction> seedInvoice() {
    return <Transaction>[
      Transaction(
        id: 'i1',
        title: 'Amazon',
        category: 'Compras',
        date: DateTime(2026, 6, 29),
        amount: -274.99,
        icon: 'shopping',
      ),
      Transaction(
        id: 'i2',
        title: 'Netflix',
        category: 'Assinatura',
        date: DateTime(2026, 6, 27),
        amount: -55.90,
        icon: 'subscription',
      ),
      Transaction(
        id: 'i3',
        title: 'Posto Ipiranga',
        category: 'Transporte',
        date: DateTime(2026, 6, 25),
        amount: -180.00,
        icon: 'transport',
      ),
      Transaction(
        id: 'i4',
        title: 'Restaurante Fasano',
        category: 'Alimentação',
        date: DateTime(2026, 6, 23),
        amount: -312.40,
        icon: 'food',
      ),
    ];
  }

  /// Real async path: fetches through the API service and maps to domain.
  /// Falls back to the seed when the demo endpoint returns no cards.
  Future<List<PaymentCard>> fetch() async {
    final apiModels = await _service.fetchCards();
    if (apiModels.isEmpty) {
      return seed();
    }
    return apiModels.map((m) => m.toDomain()).toList();
  }
}
