// import 'package:flutter/material.dart';
//
// import '../screens/details_screen.dart';
//
// class TaskItem extends StatelessWidget {
//   const TaskItem({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return const DetailsScreen();
//             },
//           ),
//         );
//       },
//
//
//         child: Padding(
//         padding: const EdgeInsets.all(9.0),
//         child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Image.asset(
//         'assets/images/grocery_image.png',
//         width: 48,
//         height: 48,
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//         child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Row(
//         children: [
//         const Expanded(
//         child: Text(
//         'Grocery Shopping',
//         style: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         ),
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         ),
//         ),
//         Container(
//         padding: const EdgeInsets.symmetric(
//         horizontal: 14, vertical: 5),
//         decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 248, 212, 224),
//         borderRadius: BorderRadius.circular(5),
//         ),
//         child: const Text(
//         'Waiting',
//         style: TextStyle(
//         color: Colors.orange,
//         fontSize: 12,
//         fontWeight: FontWeight.w500,
//         ),
//         ),
//         ),
//         const SizedBox(width: 8),
//         const Icon(Icons.more_vert_outlined,
//         color: Colors.purple, size: 20),
//         ],
//         ),
//         const SizedBox(height: 4),
//         Text(
//         'This application is designed for managing your daily todo to remind you because you are getting old YA LOSER',
//         style: TextStyle(color: Colors.grey.shade600),
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//         ),
//         const SizedBox(height: 8),
//         const Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Row(
//         children: [
//         Icon(Icons.flag_outlined,
//         color: Colors.blueAccent, size: 16),
//         SizedBox(width: 4),
//         Text(
//         'Low',
//         style: TextStyle(color: Colors.blueAccent),
//         ),
//         ],
//         ),
//         Text(
//         '30/12/2022',
//         style: TextStyle(color: Colors.grey),
//         ),
//         ],
//         ),
//         ],
//         ),
//         ),
//         ],
//         )
//         ,
//         ),
//
//
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../data_layer/model/task_models.dart';
import '../screens/details_screen.dart';


class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task}); // تعديل المُنشئ ليأخذ TaskModel

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const DetailsScreen();
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/grocery_image.png',  //  task.image// عرض صورة المهمة
              width: 48,
              height: 48,
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
                          task.title, // عرض عنوان المهمة
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(task.priority),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          task.priority, // عرض الأولوية
                          style: TextStyle(
                            color: _getPriorityTextColor(task.priority),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.more_vert_outlined, color: Colors.purple, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
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
                          Icon(Icons.flag_outlined, color: Colors.blueAccent, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            task.priority, // عرض الأولوية في مكان آخر (أو يمكنك تعديله حسب حاجتك)
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),
                      Text(
                        task.date, // عرض التاريخ
                        style: const TextStyle(color: Colors.grey),
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

  // دوال مساعدة لتحديد ألوان الأولوية
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
}

