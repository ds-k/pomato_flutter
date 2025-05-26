import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomato_flutter/ui/viewmodels/auth_viewmodel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            ElevatedButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).logout(context);
              },
              child: const Text('Logout test'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).refreshToken();
              },
              child: const Text('refresh test'),
            ),
          ],
        ),
      ),
    );
  }
}
