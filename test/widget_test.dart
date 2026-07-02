import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:fintech/ui/features/wallet/view_models/wallet_view_model.dart';
import 'package:fintech/ui/features/wallet/views/wallet_screen.dart';

void main() {
  testWidgets('WalletScreen renders header and seeded transactions',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(500, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<WalletViewModel>(
          create: (_) => WalletViewModel(),
          child: const WalletScreen(),
        ),
      ),
    );
    await tester.pump();

    // Two key pieces of content must be present.
    expect(find.text('Olá, Ana'), findsOneWidget);
    expect(find.text('Mercado Livre'), findsOneWidget);
  });
}
