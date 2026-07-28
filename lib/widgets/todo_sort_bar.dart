import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo_sort.dart';

class TodoSortBar extends StatelessWidget {
  final TodoSort currentSort;
  final ValueChanged<TodoSort> onSortChanged;

  const TodoSortBar({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ...TodoSort.values.map((sort){
          return ChoiceChip(
            label: Text(sort.name), 
            selected: sort == currentSort,
            onSelected: (_) => onSortChanged(sort),
          );
        }).toList(),
      ],
    );
  }
}