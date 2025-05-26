import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomato_flutter/ui/viewmodels/auth_viewmodel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.read(authViewModelProvider).provider);
    return const Scaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
