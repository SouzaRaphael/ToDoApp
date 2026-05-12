import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, 
    required this.animation, 
    required this.task, 
    required this.markAsDone, 
    required this.removeTask
  });

  final Animation<double> animation;
  final Task task;
  final Function(Task, bool) markAsDone;
  final Function(Task) removeTask;

  @override
  Widget build(BuildContext context) => SizeTransition(
    axisAlignment: 1,
    sizeFactor: CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
    child: Card(
      child: Row(
        children: [
          Checkbox(
            value: task.done,
            onChanged: (value) => markAsDone(task, value!)
          ),
          Expanded(child: Text(task.name)),
          IconButton(
            onPressed: () => removeTask(task),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    ),
  );
}