import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/utilities/app_colors.dart';

import 'package:todo_app/features/auth/presentation_layer/screens/login_screen_view.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_state.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/details_screen.dart';

import '../widget/task_item.dart';
import 'add_task/add_new_task.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> list = ["All", "In Progress", "Waiting", "Finished"];

  String selectedItem = "";

  @override
  void initState() {
    selectedItem = list[0];
    context.read<TaskCubit>().getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Logo'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const Icon(Icons.person, size: 30, color: Colors.purple),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreenView()),
              );
            },
            child: const Icon(Icons.logout, color: Colors.purple),
          ),
          const SizedBox(width: 20),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "Qr",
            elevation: 1,
            mini: true,
            backgroundColor: AppColors.lightPurpleColor,
            child: Icon(
              Icons.qr_code,
              color: AppColors.mainColor,
            ),
            onPressed: () {},
            shape: const CircleBorder(),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "Add",
            backgroundColor: AppColors.mainColor,
            elevation: 1,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNewTask(),
                ),
              );
            },
            shape: const CircleBorder(),
          ),
        ],
      ),

//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "My Tasks",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               height: 40,
//               child: TabBar(
//                 onTap: (index) {
//                   setState(() {
//                     selectedItem = list[index];
//                   });
//                 },
//                 tabs: list
//                     .map(
//                       (String item) => Tab(
//                         child: Container(
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                             color: item == selectedItem
//                                 ? Colors.transparent
//                                 : AppColors.lightPurpleColor,
//
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Center(
//                             child: Text(
//                               item,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//             // state is Loading ? CircularProgressIndicator() :
//
//             // BlocBuilder(builder: (context,state){
//             //
//             //   switch(state) {
//             //     case ErrorState():
//             //       return Text("error");
//             //     case LoadedState(:final tasks):
//             //
//             //     case LoadingState():
//             //     default:
//             //       return CircularProgressIndicator();
//             //   }
//             // }),
//          Expanded(
//     child: TabBarView(
//     physics: const NeverScrollableScrollPhysics(),
//     children: list
//         .map(
//     (e) =>
//     ListView.builder(
//
//     ///  هنا استخدم .length  لما احتاج اضهر كل العدد بصورة تلقائية بدون  limitation
//     // itemCount: taskCubit.tasksList.length,
//     // itemBuilder: (context, index) => TaskItem(
//     //   task: taskCubit.tasksList[index],
//     // ),
//     // itemCount: tasks.length,
//     itemBuilder: (context, index) => TaskItem(),
//     ),
//     )
//         .toList(),
//     ),
//     ),
//
//             // Padding(
//             //   padding: const EdgeInsets.all(9.0),
//             //   child: Row(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //       Image.asset(
//             //         'assets/images/grocery_image.png',
//             //         width: 48,
//             //         height: 48,
//             //       ),
//             //       const SizedBox(width: 20),
//             //       Expanded(
//             //         child: SingleChildScrollView(
//             //           child: Column(
//             //             crossAxisAlignment: CrossAxisAlignment.start,
//             //             children: [
//             //               Row(
//             //                 children: [
//             //                   const Expanded(
//             //                     child: Text(
//             //                       'Grocery Shopping',
//             //                       style: TextStyle(
//             //                         fontSize: 16,
//             //                         fontWeight: FontWeight.bold,
//             //                       ),
//             //                       overflow: TextOverflow.ellipsis,
//             //                     ),
//             //                   ),
//             //                   Container(
//             //                     padding: const EdgeInsets.symmetric(
//             //                         horizontal: 14, vertical: 5),
//             //                     decoration: BoxDecoration(
//             //                       color:
//             //                           const Color.fromARGB(255, 248, 212, 224),
//             //                       borderRadius: BorderRadius.circular(5),
//             //                     ),
//             //                     child: const Text(
//             //                       'Waiting',
//             //                       style: TextStyle(
//             //                         color: Colors.orange,
//             //                         fontSize: 12,
//             //                         fontWeight: FontWeight.w500,
//             //                       ),
//             //                     ),
//             //                   ),
//             //                   const SizedBox(width: 8),
//             //                   GestureDetector(
//             //                     onTap: () {
//             //                       Navigator.push(
//             //                         context,
//             //                         MaterialPageRoute(
//             //                             builder: (context) =>
//             //                                 const DetailsScreen()),
//             //                       );
//             //                     },
//             //                     child: const Icon(Icons.visibility_outlined,
//             //                         color: Colors.purple, size: 20),
//             //                   ),
//             //                 ],
//             //               ),
//             //               const SizedBox(height: 4),
//             //               Text(
//             //                 'This application is designed for s...',
//             //                 style: TextStyle(color: Colors.grey.shade600),
//             //               ),
//             //               const SizedBox(height: 8),
//             //               const Row(
//             //                 children: [
//             //                   Row(
//             //                     children: [
//             //                       Icon(Icons.flag_outlined,
//             //                           color: Colors.purple, size: 16),
//             //                       SizedBox(width: 4),
//             //                       Text(
//             //                         'Medium',
//             //                         style: TextStyle(color: Colors.purple),
//             //                       ),
//             //                     ],
//             //                   ),
//             //                   Padding(
//             //                     padding: EdgeInsets.symmetric(horizontal: 85),
//             //                     child: Text(
//             //                       '30/12/2022',
//             //                       style: TextStyle(color: Colors.grey),
//             //                     ),
//             //                   ),
//             //                 ],
//             //               ),
//             //             ],
//             //           ),
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             //
//
//             // Padding(
//             //   padding: const EdgeInsets.all(9.0),
//             //   child: Row(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //       Image.asset(
//             //         'assets/images/grocery_image.png',
//             //         width: 48,
//             //         height: 48,
//             //       ),
//             //       const SizedBox(width: 20),
//             //       Expanded(
//             //         child: Column(
//             //           crossAxisAlignment: CrossAxisAlignment.start,
//             //           children: [
//             //             Row(
//             //               children: [
//             //                 const Expanded(
//             //                   child: Text(
//             //                     'Grocery Shopping',
//             //                     style: TextStyle(
//             //                       fontSize: 16,
//             //                       fontWeight: FontWeight.bold,
//             //                     ),
//             //                     overflow: TextOverflow.ellipsis,
//             //                   ),
//             //                 ),
//             //                 Container(
//             //                   padding: const EdgeInsets.symmetric(
//             //                       horizontal: 14, vertical: 5),
//             //                   decoration: BoxDecoration(
//             //                     color: const Color.fromARGB(255, 237, 212, 248),
//             //                     borderRadius: BorderRadius.circular(5),
//             //                   ),
//             //                   child: const Text(
//             //                     'Inprogress',
//             //                     style: TextStyle(
//             //                       color: Color.fromARGB(255, 184, 13, 214),
//             //                       fontSize: 12,
//             //                       fontWeight: FontWeight.w500,
//             //                     ),
//             //                   ),
//             //                 ),
//             //                 const SizedBox(width: 8),
//             //                 const Icon(Icons.visibility_outlined,
//             //                     color: Colors.purple, size: 20),
//             //               ],
//             //             ),
//             //             const SizedBox(height: 4),
//             //             Text(
//             //               'This application is designed for s...',
//             //               style: TextStyle(color: Colors.grey.shade600),
//             //             ),
//             //             const SizedBox(height: 8),
//             //             const Row(
//             //               children: [
//             //                 Row(
//             //                   children: [
//             //                     Icon(Icons.flag_outlined,
//             //                         color: Color.fromARGB(255, 247, 154, 33),
//             //                         size: 16),
//             //                     SizedBox(width: 4),
//             //                     Text(
//             //                       'Heigh',
//             //                       style: TextStyle(
//             //                           color: Color.fromARGB(255, 248, 155, 33)),
//             //                     ),
//             //                   ],
//             //                 ),
//             //                 Padding(
//             //                   padding: EdgeInsets.symmetric(horizontal: 95),
//             //                   child: Text(
//             //                     '30/12/2022',
//             //                     style: TextStyle(color: Colors.grey),
//             //                   ),
//             //                 ),
//             //               ],
//             //             ),
//             //           ],
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(9.0),
//             //   child: Row(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //       Image.asset(
//             //         'assets/images/grocery_image.png',
//             //         width: 48,
//             //         height: 48,
//             //       ),
//             //       const SizedBox(width: 20),
//             //       Expanded(
//             //         child: Column(
//             //           crossAxisAlignment: CrossAxisAlignment.start,
//             //           children: [
//             //             Row(
//             //               children: [
//             //                 const Expanded(
//             //                   child: Text(
//             //                     'Grocery Shopping',
//             //                     style: TextStyle(
//             //                       fontSize: 16,
//             //                       fontWeight: FontWeight.bold,
//             //                     ),
//             //                     overflow: TextOverflow.ellipsis,
//             //                   ),
//             //                 ),
//             //                 Container(
//             //                   padding: const EdgeInsets.symmetric(
//             //                       horizontal: 14, vertical: 5),
//             //                   decoration: BoxDecoration(
//             //                     color: const Color.fromARGB(255, 229, 245, 252),
//             //                     borderRadius: BorderRadius.circular(5),
//             //                   ),
//             //                   child: const Text(
//             //                     'Finshed',
//             //                     style: TextStyle(
//             //                       color: Colors.blueAccent,
//             //                       fontSize: 12,
//             //                       fontWeight: FontWeight.w500,
//             //                     ),
//             //                   ),
//             //                 ),
//             //                 const SizedBox(width: 8),
//             //                 const Icon(Icons.visibility_outlined,
//             //                     color: Colors.purple, size: 20),
//             //               ],
//             //             ),
//             //             const SizedBox(height: 4),
//             //             Text(
//             //               'This application is designed for s...',
//             //               style: TextStyle(color: Colors.grey.shade600),
//             //             ),
//             //             const SizedBox(height: 8),
//             //             const Row(
//             //               children: [
//             //                 Row(
//             //                   children: [
//             //                     Icon(Icons.flag_outlined,
//             //                         color: Colors.purple, size: 16),
//             //                     SizedBox(width: 4),
//             //                     Text(
//             //                       'Medium',
//             //                       style: TextStyle(color: Colors.purple),
//             //                     ),
//             //                   ],
//             //                 ),
//             //                 Padding(
//             //                   padding: EdgeInsets.symmetric(horizontal: 85),
//             //                   child: Text(
//             //                     '30/12/2022',
//             //                     style: TextStyle(color: Colors.grey),
//             //                   ),
//             //                 ),
//             //               ],
//             //             ),
//             //           ],
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

      body: DefaultTabController(
        length: list.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "My Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    selectedItem = list[index];
                  });
                },
                tabs: list
                    .map(
                      (String item) => Tab(
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: item == selectedItem
                                ? Colors.transparent
                                : AppColors.lightPurpleColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(item),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<TaskCubit, TodoState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ErrorState) {
                    return const Center(child: Text("Error loading tasks"));
                  } else if (state is LoadedState) {
                    final tasks = selectedItem == "All"
                        ? state.tasks
                        : state.tasks
                            .where((task) => task.state == selectedItem)
                            .toList();

                    if (tasks.isEmpty) {
                      return const Center(child: Text("No tasks found"));
                    }

                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) => GestureDetector(
                        behavior: HitTestBehavior.translucent, //  مفيدددة جدا
                        child: TaskItem(task: tasks[index]),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => DetailsScreen(
                          //       detailsitem: tasks[index],
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
