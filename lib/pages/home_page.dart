import 'package:flutter/material.dart';

class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title, 
    required this.isDone,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        InkWell(
                          onTap: () {
                            setState(() {
                              todo.isDone = !todo.isDone;
                            });
                          },
                          child: Icon(
                            todo.isDone 
                            ? Icons.check_box 
                            : Icons.check_box_outline_blank),
                        ),
                      title: Text(todo.title),
                      trailing: InkWell(
                        onTap: () {
                          setState(() {
                            todoList.removeAt(index);
                          });
                        },
                        child: const Icon(Icons.delete_outline),
                      ),
                    );
                  }
                ),
              ),
            ],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('add todo'),
                content: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'add todo',
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      _textController.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () {
                      final title = _textController.text.trim();
                      if (title.isEmpty){
                        return;
                      }
                      setState(() {
                        todoList.add(
                          Todo(
                            title: title, 
                            isDone: false
                          )
                        );
                      });
                      _textController.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}