import 'dart:convert';

class Todo{  
  String title;
  bool isDone;

  
  Todo({
    required this.title,
    required this.isDone,
  });

  Todo.create({required this.title}) : isDone = false;

  Map<String, dynamic> toMap(){ 
  return {
    "title": this.title, 
    "isDone": this.isDone, 
  };
}

  factory Todo.fromMap(Map<String, dynamic> map){  
    return Todo( 
      title: map["title"],
      isDone: map["isDone"],
    ); 
  }

  String toJson(){ 
  return jsonEncode(toMap()); 
  }

  factory Todo.fromJson(String json){ 
    return Todo.fromMap(
      jsonDecode(json)
    ); 
  }
}