// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../data_layer/model/task_models.dart';
import '../screens/details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem(
      {super.key, required this.task}); // تعديل المُنشئ ليأخذ TaskModel

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
            // CachedNetworkImage(
            //   width: 48,
            //   height: 48,
            //   placeholder: (context, url) => const CircularProgressIndicator(),
            //   imageUrl: task.image,
            // ),

            CachedNetworkImage(
              imageUrl: task.image,
              width: 48,
              height: 48,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: Icon(Icons.task, color: Colors.grey[400]),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
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
                          color: _getPriorityColor(task.priority),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          task.priority,
                          style: TextStyle(
                            color: _getPriorityTextColor(task.priority),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.more_vert_outlined,
                          color: Colors.purple, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // const Text(
                      //   'Status: ',
                      //   style: TextStyle(fontWeight: FontWeight.w500),
                      // ),
                      Text(
                        task.state,
                        style: TextStyle(
                          color: _getStateColor(task.state),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
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
                          Icon(Icons.flag_outlined,
                              color: Colors.blueAccent, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            task.priority,
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),
                      // Text(
                      //   task.date, // عرض التاريخ
                      //   style: const TextStyle(color: Colors.black),
                      // ),
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
      case 'Low':
        return Colors.blueAccent.withOpacity(0.2);
      case 'Medium':
        return Colors.orange.withOpacity(0.2);
      case 'High':
        return Colors.red.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color _getPriorityTextColor(String priority) {
    switch (priority) {
      case 'Low':
        return Colors.blueAccent;
      case 'Medium':
        return Colors.orange;
      case 'High':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getStateColor(String state) {
    switch (state) {
      case 'Waiting':
        return Colors.orange;
      case 'InProgress':
        return Colors.blue;
      case 'Finished':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
