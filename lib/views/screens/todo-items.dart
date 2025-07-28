// widgets/todo_item.dart
import 'package:flutter/material.dart';
import 'package:goto/models/todo-model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;

  const TodoItem({
    required this.todo,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) => onToggle(),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        '${todo.time.hour}:${todo.time.minute.toString().padLeft(2, '0')} ${todo.time.hour < 12 ? 'am' : 'pm'} #${todo.category}',
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {
          // Show options menu
        },
      ),
    );
  }
}