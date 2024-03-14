import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo toDo;
  final onToDoChanged;
  final onDelete;

  const ToDoItem({
    super.key,
    required this.toDo,
    this.onToDoChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTap: () {
          onToDoChanged(toDo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          toDo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          toDo.todoText!,
          style: TextStyle(
            fontSize: 20,
            color: tdBlack,
            decoration: toDo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              onDelete(toDo.id);
            },
            icon: const Icon(Icons.delete),
            iconSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
