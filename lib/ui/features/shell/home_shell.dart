import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../card/view_models/card_view_model.dart';
import '../card/views/card_detail_screen.dart';
import '../profile/view_models/profile_view_model.dart';
import '../profile/views/profile_screen.dart';
import '../statement/view_models/statement_view_model.dart';
import '../statement/views/statement_screen.dart';
import '../wallet/view_models/wallet_view_model.dart';
import '../wallet/views/wallet_screen.dart';

/// Bottom-navigation shell hosting the four primary tabs. Push routes
/// (send / receive / transactions / add-card) open on top of this shell.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late int _index = widget.initialIndex;

  late final List<Widget> _pages = <Widget>[
    ChangeNotifierProvider<WalletViewModel>(
      create: (_) => WalletViewModel(),
      child: const WalletScreen(),
    ),
    ChangeNotifierProvider<StatementViewModel>(
      create: (_) => StatementViewModel(),
      child: const StatementScreen(),
    ),
    ChangeNotifierProvider<CardViewModel>(
      create: (_) => CardViewModel(),
      child: const CardDetailScreen(),
    ),
    ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel(),
      child: const ProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (int i) => setState(() => _index = i),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Extrato',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card_outlined),
            selectedIcon: Icon(Icons.credit_card),
            label: 'Cartões',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
