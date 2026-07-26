import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo_filter.dart';

class TodoFilterBar extends StatelessWidget {
  final TodoFilter currentFilter;
  final ValueChanged<TodoFilter> onFilterChanged;

  const TodoFilterBar({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ...TodoFilter.values.map((filter){
          return ChoiceChip(
            label: Text(filter.name), 
            selected: filter == currentFilter,
            onSelected: (_) => onFilterChanged(filter),
          );
        }).toList(),
      ],
    );
  }
}