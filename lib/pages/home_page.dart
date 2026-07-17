import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/widgets/todo_tile.dart';
import 'package:to_do_app/widgets/empty_todo.dart';

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
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _toggleTodo(Todo todo){
    setState(() {
      todo.isDone =  !todo.isDone;
    });
  }

  void _showAddDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Add Todo',
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
              child: const Text('Add Todo'),
              onPressed: _addTodo,
            ),
          ],
        );
      }
    );
  }

  void _addTodo(){
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
  }

  void _showEditDialog(Todo todo){
    _textController.text = todo.title;

    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text("Edit Todo"),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: "Edit Todo",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _textController.clear();
                Navigator.pop(context);
              }, 
              child: const Text("Cancel")
            ),
            TextButton(
              onPressed:() => _editTodo(todo), 
              child: const Text("Save")
            )
          ],
        );
    });
  }

  void _editTodo(Todo todo){
    final title = _textController.text.trim();
    if(title.isEmpty){
      return;
    }
    setState(() {
      todo.title = title;
    });
    _textController.clear();
    Navigator.pop(context);
  }

  void _showDeleteDialog(Todo todo){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text("Delete Todo"),
          content: const Text("Apakah Anda yakin ingin menghapus todo ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                _deleteTodo(todo);
              }, 
              child: const Text("Delete")
            )
          ],
        );
      }
    );
  }

  void _deleteTodo(Todo todo){
    setState(() {
      todoList.remove(todo);
    });
  }

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
                child: todoList.isEmpty
                ? const EmptyTodo()
                
                : ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    final todo = todoList[index];
                    return TodoTile(
                      todo: todo, 
                      onToggle: () => _toggleTodo(todo), 
                      onDelete: () => _showDeleteDialog(todo),
                      onEdit: () => _showEditDialog(todo),
                    );
                  }
                ),
              ),
            ],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}