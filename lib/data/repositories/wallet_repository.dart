import '../../domain/models/transaction.dart';
import '../services/transaction_api_service.dart';

/// Provides wallet data: a synchronous [seed] for instant UI content and an
/// asynchronous [fetch] that goes through the real API service.
class WalletRepository {
  WalletRepository({TransactionApiService? service})
      : _service = service ?? TransactionApiService();

  final TransactionApiService _service;

  /// Synchronous seed so the first frame already has content (used in tests
  /// and as an optimistic cache). Returns the recent highlights for the home.
  List<Transaction> seed() => seedAll().take(6).toList();

  /// Full synchronous history used by the Transactions screen and Statement.
  List<Transaction> seedAll() {
    return <Transaction>[
      Transaction(
        id: 't1',
        title: 'Salário',
        category: 'Renda',
        date: DateTime(2026, 6, 30),
        amount: 8500.00,
        icon: 'salary',
      ),
      Transaction(
        id: 't2',
        title: 'Mercado Livre',
        category: 'Compras',
        date: DateTime(2026, 6, 30),
        amount: -159.90,
        icon: 'shopping',
      ),
      Transaction(
        id: 't3',
        title: 'iFood',
        category: 'Alimentação',
        date: DateTime(2026, 6, 29),
        amount: -67.30,
        icon: 'food',
      ),
      Transaction(
        id: 't4',
        title: 'Uber',
        category: 'Transporte',
        date: DateTime(2026, 6, 29),
        amount: -24.50,
        icon: 'transport',
      ),
      Transaction(
        id: 't5',
        title: 'Pix recebido — Bruno',
        category: 'Transferência',
        date: DateTime(2026, 6, 28),
        amount: 250.00,
        icon: 'transfer',
      ),
      Transaction(
        id: 't6',
        title: 'Spotify',
        category: 'Assinatura',
        date: DateTime(2026, 6, 28),
        amount: -21.90,
        icon: 'subscription',
      ),
      Transaction(
        id: 't7',
        title: 'Farmácia São Paulo',
        category: 'Saúde',
        date: DateTime(2026, 6, 27),
        amount: -88.40,
        icon: 'health',
      ),
      Transaction(
        id: 't8',
        title: 'Conta de luz',
        category: 'Contas',
        date: DateTime(2026, 6, 27),
        amount: -213.15,
        icon: 'bills',
      ),
      Transaction(
        id: 't9',
        title: 'Reembolso viagem',
        category: 'Reembolso',
        date: DateTime(2026, 6, 26),
        amount: 430.00,
        icon: 'refund',
      ),
      Transaction(
        id: 't10',
        title: 'Cinema Multiplex',
        category: 'Lazer',
        date: DateTime(2026, 6, 26),
        amount: -46.00,
        icon: 'entertainment',
      ),
      Transaction(
        id: 't11',
        title: 'Posto Ipiranga',
        category: 'Transporte',
        date: DateTime(2026, 6, 25),
        amount: -180.00,
        icon: 'transport',
      ),
      Transaction(
        id: 't12',
        title: 'Rendimento CDB',
        category: 'Investimento',
        date: DateTime(2026, 6, 25),
        amount: 96.72,
        icon: 'investment',
      ),
      Transaction(
        id: 't13',
        title: 'Padaria Real',
        category: 'Alimentação',
        date: DateTime(2026, 6, 24),
        amount: -32.80,
        icon: 'food',
      ),
      Transaction(
        id: 't14',
        title: 'Amazon',
        category: 'Compras',
        date: DateTime(2026, 6, 24),
        amount: -274.99,
        icon: 'shopping',
      ),
    ];
  }

  /// Real async path: fetches through the API service and maps to domain.
  /// Falls back to the seed when the demo endpoint returns no transactions.
  Future<List<Transaction>> fetch() async {
    final apiModels = await _service.fetchTransactions();
    if (apiModels.isEmpty) {
      return seedAll();
    }
    return apiModels.map((m) => m.toDomain()).toList();
  }
}
