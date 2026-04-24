import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/add_edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => provider.deleteTask(task.id!),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => provider.toggleComplete(task),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null) Text(task.description!),
            if (task.dueDate != null)
              Text("Due: ${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}"),
            Row(
              children: [
                Chip(label: Text(task.priority), backgroundColor: _priorityColor(task.priority)),
                const SizedBox(width: 8),
                Chip(label: Text(task.category)),
              ],
            ),
          ],
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddEditTaskScreen(task: task)),
        ),
      ),
    );
  }

  Color _priorityColor(String priority) {
    if (priority == "High") return Colors.red.shade100;
    if (priority == "Medium") return Colors.orange.shade100;
    return Colors.green.shade100;
  }
}