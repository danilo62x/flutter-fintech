import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/transaction.dart';
import '../../../core/widgets/app_widgets.dart';
import '../view_models/wallet_view_model.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WalletViewModel>();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive: stretch on phones, cap width and centre on tablets.
            final double maxWidth =
                constraints.maxWidth >= 720 ? 560 : constraints.maxWidth;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                  children: <Widget>[
                    _Header(name: vm.userName, initials: vm.userInitials),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => context.push('/card'),
                      child: BalanceCard(
                        balance: vm.balance,
                        cardLast4: vm.cardNumber,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _QuickActions(
                      onSend: () => context.push('/send'),
                      onReceive: () => context.push('/receive'),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _MiniStat(
                            icon: Icons.south_west,
                            label: 'Entradas',
                            value: currencyFormat.format(vm.income),
                            color: const Color(0xFF1B8A4B),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _MiniStat(
                            icon: Icons.north_east,
                            label: 'Saídas',
                            value: currencyFormat.format(vm.expenses.abs()),
                            color: const Color(0xFFC62828),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SectionHeader(
                      title: 'Transações',
                      actionLabel: 'Ver tudo',
                      onAction: () => context.push('/transactions'),
                    ),
                    const SizedBox(height: 4),
                    for (final Transaction t in vm.transactions)
                      TransactionTile(
                        icon: materialIcon(t.icon),
                        title: t.title,
                        subtitle: '${t.category}  •  ${_shortDate(t.date)}',
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/send'),
        icon: const Icon(Icons.bolt),
        label: const Text('Pix'),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
    );
  }

  static String _shortDate(DateTime date) {
    final String d = date.day.toString().padLeft(2, '0');
    final String m = date.month.toString().padLeft(2, '0');
    return '$d/$m';
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.name, required this.initials});

  final String name;
  final String initials;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Olá, $name',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Bem-vinda de volta',
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 24,
          backgroundColor: scheme.primaryContainer,
          child: Text(
            initials,
            style: textTheme.titleMedium?.copyWith(
              color: scheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onSend, required this.onReceive});

  final VoidCallback onSend;
  final VoidCallback onReceive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        QuickAction(icon: Icons.bolt_outlined, label: 'Pix', onTap: onSend),
        QuickAction(icon: Icons.arrow_upward, label: 'Enviar', onTap: onSend),
        QuickAction(
          icon: Icons.arrow_downward,
          label: 'Receber',
          onTap: onReceive,
        ),
        QuickAction(
          icon: Icons.qr_code_scanner,
          label: 'Pagar',
          onTap: onReceive,
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
