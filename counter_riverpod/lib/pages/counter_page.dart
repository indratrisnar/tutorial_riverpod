import 'package:counter_riverpod/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build Page');
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context, wiRef, child) {
          print('build Text Counter');
          int counter = wiRef.watch(counterNotifierProvider);
          return Text('$counter');
        }),
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton(
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
            onPressed: () {
              ref.read(counterNotifierProvider.notifier).decrement();
            },
          ),
          FloatingActionButton(
            heroTag: 'increment',
            child: const Icon(Icons.add),
            onPressed: () {
              ref.read(counterNotifierProvider.notifier).increment();
            },
          ),
        ],
      ),
    );
  }
}
