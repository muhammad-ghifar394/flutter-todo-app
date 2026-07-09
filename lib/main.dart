import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Todo'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_box_outline_blank),
                    const SizedBox(width: 8),
                    const Text('Belajar Flutter'),
                  ]
                ),
                Row(
                  children: [
                    const Icon(Icons.check_box_outline_blank),
                    const SizedBox(width: 8),
                    const Text('Belajar Git'),
                  ]
                ),
                Row(
                  children: [
                    const Icon(Icons.check_box_outline_blank),
                    const SizedBox(width: 8),
                    const Text('Push ke GitHub'),
                  ]
                ),
              ],
            )
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      )
    );
  }
}
