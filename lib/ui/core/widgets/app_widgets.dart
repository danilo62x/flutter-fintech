import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Currency formatter shared across the wallet UI (Brazilian Real).
final NumberFormat currencyFormat =
    NumberFormat.currency(locale: 'pt_BR', symbol: r'R$ ', decimalDigits: 2);

/// Compact currency formatter without the trailing symbol spacing.
final NumberFormat compactCurrency =
    NumberFormat.currency(locale: 'pt_BR', symbol: r'R$', decimalDigits: 2);

/// Vibrant palette used by charts and category chips (reads well in both themes).
const List<Color> kCategoryPalette = <Color>[
  Color(0xFF6C5CE7),
  Color(0xFF00B894),
  Color(0xFFFF6B6B),
  Color(0xFFF7B731),
  Color(0xFF0984E3),
  Color(0xFFE17055),
];

/// Maps a semantic icon key to a const Material [IconData].
IconData materialIcon(String key) {
  switch (key) {
    case 'salary':
    case 'income':
      return Icons.payments_outlined;
    case 'shopping':
      return Icons.shopping_bag_outlined;
    case 'food':
      return Icons.restaurant_outlined;
    case 'transport':
      return Icons.local_taxi_outlined;
    case 'transfer':
      return Icons.swap_horiz;
    case 'subscription':
      return Icons.music_note_outlined;
    case 'health':
      return Icons.medical_services_outlined;
    case 'bills':
      return Icons.receipt_long_outlined;
    case 'refund':
      return Icons.replay_outlined;
    case 'entertainment':
      return Icons.local_movies_outlined;
    case 'investment':
      return Icons.trending_up;
    default:
      return Icons.receipt_long_outlined;
  }
}

/// Gradient balance card (~200 tall) with masked card number and brand mark.
class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.balance,
    required this.cardLast4,
  });

  final double balance;
  final String cardLast4;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary,
            Color.alphaBlend(
              scheme.tertiary.withValues(alpha: 0.55),
              scheme.primary,
            ),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Saldo disponível',
                style: textTheme.labelLarge?.copyWith(
                  color: scheme.onPrimary.withValues(alpha: 0.85),
                ),
              ),
              Icon(
                Icons.contactless_outlined,
                color: scheme.onPrimary.withValues(alpha: 0.9),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            currencyFormat.format(balance),
            style: textTheme.headlineMedium?.copyWith(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '••••  ••••  ••••  $cardLast4',
                    style: textTheme.titleMedium?.copyWith(
                      color: scheme.onPrimary,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'VISA',
                  style: textTheme.titleMedium?.copyWith(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Larger, full credit-card visual reused by the card detail and add-card
/// preview. Renders holder, number, expiry, brand and an optional frozen scrim.
class BankCard extends StatelessWidget {
  const BankCard({
    super.key,
    required this.holder,
    required this.number,
    required this.expiry,
    required this.brand,
    this.label = 'Cartão físico',
    this.frozen = false,
    this.height = 210,
    this.colors,
  });

  final String holder;
  final String number;
  final String expiry;
  final String brand;
  final String label;
  final bool frozen;
  final double height;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final List<Color> gradient = colors ??
        <Color>[
          scheme.primary,
          Color.alphaBlend(
            scheme.tertiary.withValues(alpha: 0.6),
            scheme.primary,
          ),
        ];
    final Color onCard = Colors.white;

    return Container(
      height: height,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.35),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    label,
                    style: textTheme.labelLarge?.copyWith(
                      color: onCard.withValues(alpha: 0.85),
                    ),
                  ),
                  Icon(
                    Icons.contactless_outlined,
                    color: onCard.withValues(alpha: 0.9),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Chip.
              Container(
                width: 42,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    colors: <Color>[
                      onCard.withValues(alpha: 0.9),
                      onCard.withValues(alpha: 0.55),
                    ],
                  ),
                ),
                child: Icon(Icons.memory, size: 20, color: gradient.first),
              ),
              const Spacer(),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  number,
                  style: textTheme.titleLarge?.copyWith(
                    color: onCard,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'TITULAR',
                          style: textTheme.labelSmall?.copyWith(
                            color: onCard.withValues(alpha: 0.7),
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          holder.isEmpty ? 'NOME NO CARTÃO' : holder,
                          style: textTheme.titleSmall?.copyWith(
                            color: onCard,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'VALIDADE',
                        style: textTheme.labelSmall?.copyWith(
                          color: onCard.withValues(alpha: 0.7),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        expiry.isEmpty ? 'MM/AA' : expiry,
                        style: textTheme.titleSmall?.copyWith(
                          color: onCard,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Text(
                    brand,
                    style: textTheme.titleMedium?.copyWith(
                      color: onCard,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (frozen)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.black.withValues(alpha: 0.35),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.ac_unit, color: onCard, size: 34),
                      const SizedBox(height: 6),
                      Text(
                        'Congelado',
                        style: textTheme.titleMedium?.copyWith(
                          color: onCard,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Circular tonal quick-action button with a label underneath.
class QuickAction extends StatelessWidget {
  const QuickAction({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          color: scheme.primaryContainer,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: 60,
              height: 60,
              child: Icon(icon, color: scheme.onPrimaryContainer, size: 26),
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

/// A single transaction row: tonal leading icon, title, category/date and
/// a signed amount coloured green (income) or red (expense).
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final double amount;
  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final Color amountColor =
        isIncome ? const Color(0xFF1B8A4B) : const Color(0xFFC62828);
    final String sign = isIncome ? '+ ' : '- ';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: scheme.onSecondaryContainer, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$sign${currencyFormat.format(amount.abs())}',
            style: textTheme.titleMedium?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Section title with an optional trailing action label.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel!,
              style: textTheme.labelLarge?.copyWith(color: scheme.primary),
            ),
          ),
      ],
    );
  }
}

/// Labelled linear progress used for the card limit bar.
class LimitBar extends StatelessWidget {
  const LimitBar({
    super.key,
    required this.fraction,
    required this.usedLabel,
    required this.freeLabel,
  });

  final double fraction;
  final String usedLabel;
  final String freeLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 12,
            backgroundColor: scheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              usedLabel,
              style: textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            Text(
              freeLabel,
              style: textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Settings row with a leading tonal icon, title, subtitle and a switch.
class SettingsSwitchTile extends StatelessWidget {
  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          _TonalIcon(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

/// Settings row with a leading tonal icon, title, subtitle and a chevron.
class SettingsNavTile extends StatelessWidget {
  const SettingsNavTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            _TonalIcon(icon: icon),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _TonalIcon extends StatelessWidget {
  const _TonalIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: scheme.onSecondaryContainer, size: 22),
    );
  }
}

/// A 3x4 numeric keypad used by the send-money amount screen.
class NumericKeypad extends StatelessWidget {
  const NumericKeypad({
    super.key,
    this.onDigit,
    this.onBackspace,
  });

  final ValueChanged<String>? onDigit;
  final VoidCallback? onBackspace;

  @override
  Widget build(BuildContext context) {
    final keys = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', ',', '0', '<'];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1.9,
      children: <Widget>[
        for (final String k in keys)
          _KeypadButton(
            label: k,
            onTap: () {
              if (k == '<') {
                onBackspace?.call();
              } else {
                onDigit?.call(k);
              }
            },
          ),
      ],
    );
  }
}

class _KeypadButton extends StatelessWidget {
  const _KeypadButton({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Center(
        child: label == '<'
            ? Icon(Icons.backspace_outlined, color: scheme.onSurface, size: 24)
            : Text(
                label,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
