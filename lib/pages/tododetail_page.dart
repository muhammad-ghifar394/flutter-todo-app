import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';

class TodoDetailPage extends StatelessWidget {
  final Todo todo;

  const TodoDetailPage({
    super.key,
    required this.todo
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Detail"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                title: const Text("Title"),
                subtitle: Text(todo.title),
              ),
              ListTile(
                title: const Text("Status"),
                subtitle: Text(
                  todo.isDone
                  ? "Selesai"
                  : "Belum Selesai" 
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}