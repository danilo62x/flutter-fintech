import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_widgets.dart';
import '../view_models/add_card_view_model.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddCardViewModel>();
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Adicionar cartão'),
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
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  children: <Widget>[
                    BankCard(
                      holder: vm.holder,
                      number: vm.previewNumber,
                      expiry: vm.expiry,
                      brand: vm.brand,
                      label: 'Pré-visualização',
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Dados do cartão',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _Field(
                      label: 'Número do cartão',
                      icon: Icons.credit_card,
                      initialValue: vm.number,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                      ],
                      onChanged: vm.setNumber,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: _Field(
                            label: 'Validade',
                            icon: Icons.event_outlined,
                            hint: 'MM/AA',
                            initialValue: vm.expiry,
                            keyboardType: TextInputType.datetime,
                            onChanged: vm.setExpiry,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _Field(
                            label: 'CVV',
                            icon: Icons.lock_outline,
                            hint: '123',
                            initialValue: vm.cvv,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            onChanged: vm.setCvv,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _Field(
                      label: 'Nome do titular',
                      icon: Icons.person_outline,
                      initialValue: vm.holder,
                      textCapitalization: TextCapitalization.characters,
                      onChanged: vm.setHolder,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Icon(Icons.shield_outlined,
                            size: 18, color: scheme.onSurfaceVariant),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Seus dados são criptografados de ponta a ponta.',
                            style: textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: vm.isValid ? () {} : null,
                      child: const Text('Adicionar cartão'),
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

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.icon,
    required this.initialValue,
    required this.onChanged,
    this.hint,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final IconData icon;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final String? hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: scheme.surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
