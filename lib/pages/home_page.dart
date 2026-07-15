import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/widgets/todo_tile.dart';

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

  void _toggleTodo(int index){
    setState(() {
      todoList[index].isDone =  !todoList[index].isDone;
    });
  }

  void _deleteTodo(int index){
    setState(() {
      todoList.removeAt(index);
    });
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

  void _editTodo(int index){
    final todo = todoList[index];

    _textController.text = todo.title;

    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text("Edit todo"),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: "Add todo",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _textController.clear();
                Navigator.pop(context);
              }, 
              child: Text("cancel")
            ),
            TextButton(
              onPressed: (){
                final title = _textController.text.trim();

                if(title.isEmpty){
                  return;
                }
                setState(() {
                  todo.title = title;
                  Navigator.pop(context);
                });
              }, 
              child: Text("Save")
            )
          ],
        );
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
                child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    final todo = todoList[index];
                    return TodoTile(
                      todo: todo, 
                      onToggle: () => _toggleTodo(index), 
                      onDelete: () => _deleteTodo(index),
                      onEdit: () => _editTodo(index),
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
                    onPressed: _addTodo,
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