import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/features/card/view_models/add_card_view_model.dart';
import '../ui/features/card/view_models/card_view_model.dart';
import '../ui/features/card/views/add_card_screen.dart';
import '../ui/features/card/views/card_detail_screen.dart';
import '../ui/features/receive/view_models/receive_view_model.dart';
import '../ui/features/receive/views/receive_screen.dart';
import '../ui/features/send/view_models/send_view_model.dart';
import '../ui/features/send/views/send_screen.dart';
import '../ui/features/shell/home_shell.dart';
import '../ui/features/transactions/view_models/transactions_view_model.dart';
import '../ui/features/transactions/views/transactions_screen.dart';

/// Application routes (declarative, go_router). The home is a bottom-navigation
/// shell; the remaining routes are pushed on top of it.
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeShell(),
    ),
    GoRoute(
      path: '/transactions',
      builder: (context, state) => ChangeNotifierProvider<TransactionsViewModel>(
        create: (_) => TransactionsViewModel(),
        child: const TransactionsScreen(),
      ),
    ),
    GoRoute(
      path: '/send',
      builder: (context, state) => ChangeNotifierProvider<SendViewModel>(
        create: (_) => SendViewModel(),
        child: const SendScreen(),
      ),
    ),
    GoRoute(
      path: '/receive',
      builder: (context, state) => ChangeNotifierProvider<ReceiveViewModel>(
        create: (_) => ReceiveViewModel(),
        child: const ReceiveScreen(),
      ),
    ),
    GoRoute(
      path: '/card',
      builder: (context, state) => ChangeNotifierProvider<CardViewModel>(
        create: (_) => CardViewModel(),
        child: const CardDetailScreen(),
      ),
    ),
    GoRoute(
      path: '/add-card',
      builder: (context, state) => ChangeNotifierProvider<AddCardViewModel>(
        create: (_) => AddCardViewModel(),
        child: const AddCardScreen(),
      ),
    ),
  ],
);
