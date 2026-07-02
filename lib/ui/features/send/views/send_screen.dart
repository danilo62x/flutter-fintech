import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/contact.dart';
import '../../../core/widgets/app_widgets.dart';
import '../view_models/send_view_model.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SendViewModel>();
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final Contact? to = vm.selected;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Enviar Pix'),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth =
                constraints.maxWidth >= 720 ? 460 : constraints.maxWidth;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    children: <Widget>[
                      if (to != null) _RecipientCard(contact: to),
                      const SizedBox(height: 22),
                      Text(
                        'Valor do Pix',
                        style: textTheme.labelLarge?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          currencyFormat.format(vm.amount),
                          style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Saldo disponível R\$ 12.480,55',
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                      NumericKeypad(
                        onDigit: vm.inputDigit,
                        onBackspace: vm.backspace,
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: vm.canContinue ? () {} : null,
                        child: const Text('Continuar'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RecipientCard extends StatelessWidget {
  const _RecipientCard({required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 24,
            backgroundColor: scheme.primaryContainer,
            child: Text(
              contact.initials,
              style: textTheme.titleMedium?.copyWith(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  contact.name,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${contact.bank}  •  ${contact.pixKey}',
                  style: textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Trocar'),
          ),
        ],
      ),
    );
  }
}
