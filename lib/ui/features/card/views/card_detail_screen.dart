import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/payment_card.dart';
import '../../../../domain/models/transaction.dart';
import '../../../core/widgets/app_widgets.dart';
import '../view_models/card_view_model.dart';

class CardDetailScreen extends StatelessWidget {
  const CardDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CardViewModel>();
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final PaymentCard card = vm.active;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartões'),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.push('/add-card'),
            icon: const Icon(Icons.add_card),
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
                    BankCard(
                      holder: card.holder,
                      number: '••••  ••••  ••••  ${card.last4}',
                      expiry: card.expiry,
                      brand: card.brand,
                      label: card.isVirtual ? 'Cartão virtual' : 'Cartão físico',
                      frozen: card.isFrozen,
                    ),
                    const SizedBox(height: 14),
                    _CardSelector(
                      cards: vm.cards,
                      selected: vm.activeIndex,
                      onSelect: vm.selectCard,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _CardAction(
                          icon: Icons.ac_unit,
                          label: card.isFrozen ? 'Descongelar' : 'Congelar',
                          active: card.isFrozen,
                          onTap: vm.toggleFreeze,
                        ),
                        _CardAction(
                          icon: Icons.tune,
                          label: 'Limite',
                          onTap: () {},
                        ),
                        _CardAction(
                          icon: Icons.lock_outline,
                          label: 'Bloquear',
                          onTap: () {},
                        ),
                        _CardAction(
                          icon: Icons.settings_outlined,
                          label: 'Config',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _LimitCard(card: card),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Fatura atual',
                          style: textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          currencyFormat.format(vm.invoiceTotal),
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        _InfoChip(
                          icon: Icons.event_outlined,
                          label: 'Fecha ${vm.closingDate}',
                        ),
                        const SizedBox(width: 8),
                        _InfoChip(
                          icon: Icons.schedule,
                          label: 'Vence ${vm.dueDate}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    for (final Transaction t in vm.invoice)
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

class _CardSelector extends StatelessWidget {
  const _CardSelector({
    required this.cards,
    required this.selected,
    required this.onSelect,
  });

  final List<PaymentCard> cards;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: <Widget>[
        for (int i = 0; i < cards.length; i++)
          ChoiceChip(
            selected: i == selected,
            onSelected: (_) => onSelect(i),
            avatar: Icon(
              cards[i].isVirtual ? Icons.cloud_outlined : Icons.credit_card,
              size: 18,
            ),
            label: Text('•••• ${cards[i].last4}'),
          ),
      ],
    );
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction({
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final Color bg = active ? scheme.primary : scheme.secondaryContainer;
    final Color fg = active ? scheme.onPrimary : scheme.onSecondaryContainer;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          color: bg,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: 54,
              height: 54,
              child: Icon(icon, color: fg, size: 24),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(color: scheme.onSurface),
        ),
      ],
    );
  }
}

class _LimitCard extends StatelessWidget {
  const _LimitCard({required this.card});

  final PaymentCard card;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Limite disponível',
            style: textTheme.labelLarge?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            currencyFormat.format(card.available),
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          LimitBar(
            fraction: card.usedFraction,
            usedLabel: 'Usado ${currencyFormat.format(card.used)}',
            freeLabel: 'Total ${currencyFormat.format(card.limit)}',
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: scheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
