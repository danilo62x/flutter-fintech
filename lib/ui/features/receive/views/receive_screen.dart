import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/qr_painter.dart';
import '../view_models/receive_view_model.dart';

class ReceiveScreen extends StatelessWidget {
  const ReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ReceiveViewModel>();
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Receber com Pix'),
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
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            vm.holder,
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            vm.bank,
                            style: textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 220,
                              height: 220,
                              child: CustomPaint(
                                painter: QrPainter(
                                  data: vm.qrData,
                                  foreground: const Color(0xFF111111),
                                  background: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Valor a receber',
                            style: textTheme.labelMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            currencyFormat.format(vm.amount),
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _PixKeyRow(pixKey: vm.pixKey),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.copy),
                      label: const Text('Copiar código Pix'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined),
                      label: const Text('Compartilhar'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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

class _PixKeyRow extends StatelessWidget {
  const _PixKeyRow({required this.pixKey});

  final String pixKey;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.key_outlined, size: 20, color: scheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Chave Pix',
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  pixKey,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
    );
  }
}
