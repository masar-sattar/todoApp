import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/utilities/app_colors.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/add_task/add_new_task.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/home_screen.dart';

import '../../data_layer/model/task_models.dart';
import '../screens/details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                id: widget.task.id,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.task.image,
                width: 70,
                height: 70,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.task, color: Colors.grey[400]),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.task.title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: _getStateColor(widget.task.state),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            widget.task.state,
                            style: TextStyle(
                              color: _getStateTextColor(widget.task.state),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert),
                        onSelected: (String value) {},
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNewTask(
                                      isEdit: true, task: widget.task),
                                ),
                              );
                              // print('hello masar');
                              mainContext!.read<TaskCubit>().getTasks();
                            },
                          ),
                          PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                            onTap: () async {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text('Confirm Deletion'),
                                      content: Text(
                                          'Are you sure you want to delete this task?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(dialogContext).pop();

                                            await context
                                                .read<TaskCubit>()
                                                .deleteTask(widget.task.id);

                                            if (!context.mounted) return;
                                            // Navigator.pop(context);

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext
                                                  successDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Success'),
                                                  content: Text('Delete done'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(
                                                                successDialogContext)
                                                            .pop();
                                                      },
                                                      child: Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Text(
                      widget.task.description, // عرض الوصف
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            color: _getPriorityTextColor(widget
                                .task.priority), // اللون يتبع أولوية المهمة
                            size: 25,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.task.priority,
                            style: TextStyle(
                                color: _getPriorityTextColor(
                                    widget.task.priority)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: Text(
                          widget.task.date.isNotEmpty
                              ? DateFormat("dd/MM/yyyy")
                                  .format(DateTime.parse(widget.task.date))
                              : 'No date',
                          style:
                              const TextStyle(color: AppColors.FontGrayLight),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'low':
        return Color(0xFF0087FF);
      case 'medium':
        return Color(0xFF5F33E1);
      case 'high':
        return Color(0xFFFF7D53);
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityTextColor(String priority) {
    switch (priority) {
      case 'low':
        return Color(0xFF0087FF);
      case 'medium':
        return Color(0xFF5F33E1);
      case 'high':
        return Color(0xFFFF7D53);
      default:
        return Colors.grey;
    }
  }

  Color _getStateColor(String State) {
    switch (State) {
      case 'waiting':
        return Color(0xFFFFE4F2);
      case 'inProgress':
        return Color(0xFFF0ECFF);
      case 'finished':
        return Color(0xFFE3F2FF);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color _getStateTextColor(String state) {
    switch (state) {
      case 'waiting':
        return Color(0xFFFF7D53);
      case 'inProgress':
        return Color(0xFF5F33E1);
      case 'finished':
        return Color(0xFF0087FF);
      default:
        return Colors.grey;
    }
  }
}
