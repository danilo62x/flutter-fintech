import 'package:flutter/material.dart';

import 'core/router.dart';
import 'core/theme.dart';

class FintechApp extends StatelessWidget {
  const FintechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fintech',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
