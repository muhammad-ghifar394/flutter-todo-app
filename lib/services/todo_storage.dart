import 'package:to_do_app/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoStorage {
  Future<void> saveTodos(List<Todo> todos) async{
    final prefs = await SharedPreferences.getInstance();

    final jsonList = todos.map((todo)=> todo.toJson()).toList();

    await prefs.setStringList("todos",jsonList);
  }

  Future<List<Todo>> loadTodos() async{
    final prefs = await SharedPreferences.getInstance();

    final jsonList = prefs.getStringList("todos");

    if(jsonList == null){
      return [];
    }

    final todos = jsonList
    .map((json)=>Todo.fromJson(json))
    .toList();

    return todos;
  }

}