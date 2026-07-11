import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';

class TodoTile extends StatelessWidget{
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  
  const TodoTile({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: 
        InkWell(
          onTap: onToggle,
          child: Icon(
            todo.isDone 
            ? Icons.check_box 
            : Icons.check_box_outline_blank),
        ),
      title: Text(todo.title),
      trailing: InkWell(
        onTap: onDelete,
        child: const Icon(Icons.delete_outline),
      ),
    );
  }
}