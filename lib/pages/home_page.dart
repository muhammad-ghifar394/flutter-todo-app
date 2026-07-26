import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/pages/about_page.dart';
import 'package:to_do_app/pages/tododetail_page.dart';
import 'package:to_do_app/widgets/todo_filter_bar.dart';
import 'package:to_do_app/widgets/todo_tile.dart';
import 'package:to_do_app/widgets/empty_todo.dart';
import 'package:to_do_app/services/todo_storage.dart';
import 'package:to_do_app/models/todo_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Todo> todoList = [];

  final List<Todo> filteredTodos = [];

  final TextEditingController _addController = TextEditingController();

  final TextEditingController _searchController = TextEditingController();

  final TodoStorage _storage = TodoStorage();

  TodoFilter currentFilter = TodoFilter.all;

  @override
  void initState(){
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _addController.dispose();
    super.dispose();
  }

  void _showAddDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: _addController,
            decoration: const InputDecoration(
              hintText: 'Add Todo',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                _addController.clear();
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

  void _showEditDialog(Todo todo){
    _addController.text = todo.title;

    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text("Edit Todo"),
          content: TextField(
            controller: _addController,
            decoration: const InputDecoration(
              hintText: "Edit Todo",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addController.clear();
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

  void _toggleTodo(Todo todo) async{
    setState(() {
      todo.isDone =  !todo.isDone;
    });

    await _storage.saveTodos(todoList);
    _applyFilters();
  }

  void _addTodo() async{
    final title = _addController.text.trim();
    if (title.isEmpty){
      return;
    }
    setState(() {
      todoList.add(
        Todo.create(
          title: title,
        )
      );
    });
    await _storage.saveTodos(todoList);
    _applyFilters();
    _addController.clear();
    Navigator.of(context).pop();
  }

  void _editTodo(Todo todo) async{
    final title = _addController.text.trim();
    if(title.isEmpty){
      return;
    }
    setState(() {
      todo.title = title;
    });
    await _storage.saveTodos(todoList);
    _applyFilters();
    _addController.clear();
    Navigator.pop(context);
  }

  void _deleteTodo(Todo todo)async{
    setState(() {
      todoList.remove(todo);
    });
    await _storage.saveTodos(todoList);
    _applyFilters();
  }

  Future<void> _loadTodos() async {
    final todos = await _storage.loadTodos();

    setState((){
      todoList.clear();
      todoList.addAll(todos);
    });

    _applyFilters();
  }

  void _applyFilters(){
    final String keyword = _searchController.text.trim().toLowerCase();

    final hasil = todoList.where((todo) {
      final matchKeyword = todo.title.toLowerCase().contains(keyword);

    bool matchFilter;

    switch(currentFilter){
      case TodoFilter.all:
        matchFilter = true;
        break;
      
      case TodoFilter.active:
        matchFilter = !todo.isDone;
        break;

      case TodoFilter.completed:
        matchFilter = todo.isDone;
        break;
    }

    return matchFilter && matchKeyword;
    }).toList();

    setState(() {
      filteredTodos.clear();
      filteredTodos.addAll(hasil);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('My Todo'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                )
              );
            },
            icon: Icon(Icons.info))
        ]
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  _applyFilters();
                },
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search Todo...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16,),
              TodoFilterBar(
                currentFilter: currentFilter, 
                onFilterChanged: (filter){
                  setState(() {
                    currentFilter = filter; 
                  });
                  _applyFilters();
                }),
              SizedBox(height: 16,),
              Expanded(
                child: todoList.isEmpty
                ? EmptyState(
                      icon: Icons.inbox, 
                      title: "No Todo", 
                      subtitle: "Make a new todo in + icon")
                : filteredTodos.isEmpty
                  ? EmptyState(
                      icon: Icons.search, 
                      title: "No Todo Found", 
                      subtitle: "Try another keyword")
                  : ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: TodoTile(
                          todo: todo, 
                          onToggle: () => _toggleTodo(todo), 
                          onDelete: () => _showDeleteDialog(todo),
                          onEdit: () => _showEditDialog(todo),
                          onDetail: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodoDetailPage(todo: todo)
                              )
                            );
                          },
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
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}