import '../../domain/models/category_spend.dart';
import '../../domain/models/transaction.dart';
import '../services/transaction_api_service.dart';

/// Provides statement data grouped by category for the current period.
class StatementRepository {
  StatementRepository({TransactionApiService? service})
      : _service = service ?? TransactionApiService();

  final TransactionApiService _service;

  final List<String> months = const <String>[
    'Abril',
    'Maio',
    'Junho',
  ];

  /// Synchronous seed of spending aggregated by category.
  List<CategorySpend> seed() {
    return const <CategorySpend>[
      CategorySpend(name: 'Compras', amount: 434.89, icon: 'shopping'),
      CategorySpend(name: 'Alimentação', amount: 412.50, icon: 'food'),
      CategorySpend(name: 'Transporte', amount: 384.50, icon: 'transport'),
      CategorySpend(name: 'Contas', amount: 213.15, icon: 'bills'),
      CategorySpend(name: 'Saúde', amount: 88.40, icon: 'health'),
      CategorySpend(name: 'Lazer', amount: 46.00, icon: 'entertainment'),
    ];
  }

  /// A few statement line items shown under the chart.
  List<Transaction> seedEntries() {
    return <Transaction>[
      Transaction(
        id: 's1',
        title: 'Amazon',
        category: 'Compras',
        date: DateTime(2026, 6, 24),
        amount: -274.99,
        icon: 'shopping',
      ),
      Transaction(
        id: 's2',
        title: 'Restaurante Fasano',
        category: 'Alimentação',
        date: DateTime(2026, 6, 23),
        amount: -312.40,
        icon: 'food',
      ),
      Transaction(
        id: 's3',
        title: 'Conta de luz',
        category: 'Contas',
        date: DateTime(2026, 6, 27),
        amount: -213.15,
        icon: 'bills',
      ),
    ];
  }

  /// Real async path kept for architectural completeness.
  Future<List<CategorySpend>> fetch() async {
    await _service.fetchTransactions();
    return seed();
  }
}
