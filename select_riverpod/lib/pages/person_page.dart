import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_riverpod/models/person.dart';
import 'package:select_riverpod/providers/person_provider.dart';

class PersonPage extends ConsumerWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build PersonPage');
    final edtName = TextEditingController();
    final edtAge = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: DInput(
                  controller: edtName,
                  hint: 'Name',
                ),
              ),
              IconButton(
                onPressed: () {
                  ref
                      .read(personNotifierProvider.notifier)
                      .updateName(edtName.text);
                },
                icon: const Icon(Icons.save),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DInput(
                  controller: edtAge,
                  hint: 'Age',
                ),
              ),
              IconButton(
                onPressed: () {
                  ref
                      .read(personNotifierProvider.notifier)
                      .updateAge(int.parse(edtAge.text));
                },
                icon: const Icon(Icons.save),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Consumer(
            builder: (context, wiRef, child) {
              print('build Name');
              String name = wiRef.watch(
                personNotifierProvider.select((person) => person.name),
              );
              return Text('Name: $name');
            },
          ),
          Consumer(
            builder: (context, wiRef, child) {
              print('build Age');
              int age = wiRef.watch(
                personNotifierProvider.select((person) => person.age),
              );
              return Text('Age: $age');
            },
          ),
        ],
      ),
    );
  }
}
