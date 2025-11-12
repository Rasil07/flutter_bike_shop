import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app/app_state.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final loggedIn = context.select<ApplicationState, bool>((s) => s.loggedIn);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bike Shop'),
        actions: [
          if (loggedIn)
            IconButton(
              tooltip: 'Sign out',
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await context.read<ApplicationState>().signOut();
                if (context.mounted) context.go('/sign-in');
              },
            ),
        ],
      ),
      body: SafeArea(child: child),
    );
  }
}
