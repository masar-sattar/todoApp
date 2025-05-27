import 'package:flutter/material.dart';

import '../../data_layer/model/task_models.dart';
import '../screens/details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task});

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
                id: task.id,
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
            CachedNetworkImage(
              imageUrl: task.image,
              width: 48,
              height: 48,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: Icon(Icons.task, color: Colors.grey[400]),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: _getStateColor(task.state),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          task.state,
                          style: TextStyle(
                            color: _getStateTextColor(task.state),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Row(
                  //   children: [
                  //     Text(
                  //       task.state,
                  //       style: TextStyle(
                  //         color: _getStateColor(task.state),
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Text(
                    task.description, // عرض الوصف
                    style: TextStyle(color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            color: _getPriorityTextColor(
                                task.priority), // اللون يتبع أولوية المهمة
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            task.priority,
                            style: TextStyle(
                                color: _getPriorityTextColor(task.priority)),
                          ),
                        ],
                      ),
                      Text(
                        task.date.isNotEmpty ? task.date : 'No date',
                        style: const TextStyle(color: Colors.black),
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
        return Colors.blueAccent.withOpacity(0.2);
      case 'medium':
        return Colors.orange.withOpacity(0.2);
      case 'high':
        return Colors.red.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color _getPriorityTextColor(String priority) {
    switch (priority) {
      case 'low':
        return Colors.blueAccent;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getStateColor(String State) {
    switch (State) {
      case 'waiting':
        return Colors.blueAccent.withOpacity(0.2);
      case 'inProgress':
        return Colors.orange.withOpacity(0.2);
      case 'finished':
        return Colors.red.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color _getStateTextColor(String state) {
    switch (state) {
      case 'waiting':
        return Colors.blueAccent;
      case 'inProgress':
        return Colors.orange;
      case 'finished':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
