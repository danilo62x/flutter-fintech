import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:fintech/core/theme.dart';
import 'package:fintech/ui/features/card/view_models/add_card_view_model.dart';
import 'package:fintech/ui/features/card/views/add_card_screen.dart';
import 'package:fintech/ui/features/receive/view_models/receive_view_model.dart';
import 'package:fintech/ui/features/receive/views/receive_screen.dart';
import 'package:fintech/ui/features/send/view_models/send_view_model.dart';
import 'package:fintech/ui/features/send/views/send_screen.dart';
import 'package:fintech/ui/features/shell/home_shell.dart';
import 'package:fintech/ui/features/transactions/view_models/transactions_view_model.dart';
import 'package:fintech/ui/features/transactions/views/transactions_screen.dart';

import 'golden_utils.dart';

typedef PageBuilder = Widget Function();

void main() {
  // Gallery order (light first, then the same screens dark):
  // 1 Carteira, 2 Transações, 3 Cartão, 4 Enviar, 5 Receber, 6 Extrato,
  // 7 Adicionar cartão, 8 Perfil.
  final pages = <(String, PageBuilder)>[
    ('Carteira', () => const HomeShell(initialIndex: 0)),
    (
      'Transacoes',
      () => ChangeNotifierProvider<TransactionsViewModel>(
            create: (_) => TransactionsViewModel(),
            child: const TransactionsScreen(),
          )
    ),
    ('Cartao', () => const HomeShell(initialIndex: 2)),
    (
      'Enviar',
      () => ChangeNotifierProvider<SendViewModel>(
            create: (_) => SendViewModel(),
            child: const SendScreen(),
          )
    ),
    (
      'Receber',
      () => ChangeNotifierProvider<ReceiveViewModel>(
            create: (_) => ReceiveViewModel(),
            child: const ReceiveScreen(),
          )
    ),
    ('Extrato', () => const HomeShell(initialIndex: 1)),
    (
      'AdicionarCartao',
      () => ChangeNotifierProvider<AddCardViewModel>(
            create: (_) => AddCardViewModel(),
            child: const AddCardScreen(),
          )
    ),
    ('Perfil', () => const HomeShell(initialIndex: 3)),
  ];

  testWidgets('fintech screenshots (claro+escuro)', (tester) async {
    await loadGoldenFonts();
    tester.binding.focusManager.highlightStrategy =
        FocusHighlightStrategy.alwaysTouch;
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);

    var idx = 0;
    for (final ThemeData theme in <ThemeData>[
      AppTheme.light(),
      AppTheme.dark(),
    ]) {
      for (final page in pages) {
        final key = GlobalKey();
        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: page.$2(),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 600));
        await tester.runAsync(() async {
          final boundary =
              key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
          final image = await boundary.toImage(pixelRatio: 3.0);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          final suffix = idx == 0 ? '' : '-${idx + 1}';
          final file = File('screenshots/fintech$suffix.png');
          await file.create(recursive: true);
          await file.writeAsBytes(bytes!.buffer.asUint8List());
        });
        idx++;
      }
    }
  });
}
