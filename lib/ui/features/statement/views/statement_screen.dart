import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/category_spend.dart';
import '../../../../domain/models/transaction.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/donut_chart.dart';
import '../view_models/statement_view_model.dart';

class StatementScreen extends StatelessWidget {
  const StatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StatementViewModel>();
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<DonutSlice> slices = <DonutSlice>[
      for (int i = 0; i < vm.categories.length; i++)
        DonutSlice(
          value: vm.categories[i].amount,
          color: kCategoryPalette[i % kCategoryPalette.length],
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Extrato'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.file_download_outlined),
          ),
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
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: vm.months.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, i) => ChoiceChip(
                          selected: i == vm.monthIndex,
                          onSelected: (_) => vm.selectMonth(i),
                          label: Text(vm.months[i]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Gastos em ${vm.monthLabel}',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: <Widget>[
                              DonutChart(
                                slices: slices,
                                size: 150,
                                stroke: 24,
                                centerTop: 'Total',
                                centerBottom:
                                    compactCurrency.format(vm.total),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    for (int i = 0;
                                        i < vm.categories.length && i < 4;
                                        i++)
                                      _LegendRow(
                                        color: kCategoryPalette[
                                            i % kCategoryPalette.length],
                                        label: vm.categories[i].name,
                                        value: currencyFormat
                                            .format(vm.categories[i].amount),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Por categoria',
                      style: textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    for (int i = 0; i < vm.categories.length; i++)
                      _CategoryBar(
                        category: vm.categories[i],
                        color:
                            kCategoryPalette[i % kCategoryPalette.length],
                        fraction: vm.fractionOf(vm.categories[i]),
                      ),
                    const SizedBox(height: 20),
                    Text(
                      'Lançamentos',
                      style: textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    for (final Transaction t in vm.entries)
                      TransactionTile(
                        icon: materialIcon(t.icon),
                        title: t.title,
                        subtitle: t.category,
                        amount: t.amount,
                        isIncome: t.isIncome,
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

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            value,
            style: textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({
    required this.category,
    required this.color,
    required this.fraction,
  });

  final CategorySpend category;
  final Color color;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(materialIcon(category.icon), color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      category.name,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      currencyFormat.format(category.amount),
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: fraction,
                    minHeight: 8,
                    backgroundColor: scheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
