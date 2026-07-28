import 'dart:convert';

class Todo{  
  String title;
  bool isDone;
  final DateTime createdAt;
  
  Todo({
    required this.title,
    required this.isDone,
    required this.createdAt,
  });

  Todo.create({required this.title}) 
  : isDone = false,
    createdAt = DateTime.now();

  Map<String, dynamic> toMap(){ 
    return {
      "title": this.title, 
      "isDone": this.isDone,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map){  
    return Todo( 
      title: map["title"],
      isDone: map["isDone"],
      createdAt: DateTime.parse(map["createdAt"])
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