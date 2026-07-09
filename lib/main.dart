import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title, 
    required this.isDone,
  });
}

class MyApp extends StatelessWidget {
  final List<Todo> todoList = [
    Todo(
      title: 'Belajar Flutter',
      isDone: false,
    ),
    Todo(
      title: 'Belajar Git',
      isDone: false,
    ),
    Todo(
      title: 'Push ke GitHUb',
      isDone: false,
    ),
  ];

  MyApp({super.key});

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
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      final todo = todoList[index];
                      return ListTile(
                        leading: 
                          Icon(
                            todo.isDone 
                            ? Icons.check_box 
                            : Icons.check_box_outline_blank),
                        title: Text(todo.title),
                        trailing: const Icon(Icons.delete_outline),
                      );
                    }
                  ),
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
