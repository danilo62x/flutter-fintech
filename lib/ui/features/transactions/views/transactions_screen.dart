import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/transaction.dart';
import '../../../core/widgets/app_widgets.dart';
import '../view_models/transactions_view_model.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionsViewModel>();
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final Map<String, List<Transaction>> groups = vm.grouped;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Transações'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
        ],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth =
                constraints.maxWidth >= 720 ? 560 : constraints.maxWidth;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            onChanged: vm.setQuery,
                            decoration: InputDecoration(
                              hintText: 'Buscar transações',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: scheme.surfaceContainerHigh,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: SegmentedButton<TransactionFilter>(
                              segments: const <
                                  ButtonSegment<TransactionFilter>>[
                                ButtonSegment<TransactionFilter>(
                                  value: TransactionFilter.all,
                                  label: Text('Todas'),
                                ),
                                ButtonSegment<TransactionFilter>(
                                  value: TransactionFilter.income,
                                  label: Text('Entradas'),
                                  icon: Icon(Icons.south_west),
                                ),
                                ButtonSegment<TransactionFilter>(
                                  value: TransactionFilter.expense,
                                  label: Text('Saídas'),
                                  icon: Icon(Icons.north_east),
                                ),
                              ],
                              selected: <TransactionFilter>{vm.filter},
                              showSelectedIcon: false,
                              onSelectionChanged:
                                  (Set<TransactionFilter> s) =>
                                      vm.setFilter(s.first),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: groups.isEmpty
                          ? _EmptyState()
                          : ListView(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 4, 20, 28),
                              children: <Widget>[
                                for (final MapEntry<String,
                                        List<Transaction>> entry
                                    in groups.entries) ...<Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 4),
                                    child: Text(
                                      entry.key,
                                      style: textTheme.labelLarge?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  for (final Transaction t in entry.value)
                                    TransactionTile(
                                      icon: materialIcon(t.icon),
                                      title: t.title,
                                      subtitle: t.category,
                                      amount: t.amount,
                                      isIncome: t.isIncome,
                                    ),
                                ],
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.search_off, size: 48, color: scheme.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(
            'Nenhuma transação encontrada',
            style: textTheme.titleMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
