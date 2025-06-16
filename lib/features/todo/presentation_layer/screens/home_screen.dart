// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:todo_app/components/utilities/app_colors.dart';
// import 'package:todo_app/features/auth/data_layer/data_source/auth_local_datasorce.dart';
// import 'package:todo_app/features/auth/presentation_layer/screens/login_screen_view.dart';
// import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
// import 'package:todo_app/features/todo/presentation_layer/cubit/todo_state.dart';
// import 'package:todo_app/features/todo/presentation_layer/screens/qr_scanner_screen.dart';
// import '../widget/task_item.dart';
// import 'add_task/add_new_task.dart';
// import '../../../profile/presntation/screen/profile_screen.dart';

// BuildContext? mainContext;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, String>> list = [
//     {"label": "All", "value": "all"},
//     {"label": "InProgress", "value": "inProgress"},
//     {"label": "Waiting", "value": "waiting"},
//     {"label": "Finished", "value": "finished"},
//   ];

//   String selectedItem = "";
//   int selectedIndex = 0;

//   @override
//   void initState() {
//     selectedItem = list[0]['value']!;
//     context.read<TaskCubit>().getTasks();
//     mainContext = context;
//     super.initState();
//   }

//   // @override
//   // void didChangeDependencies() {
//   //   context.read<TaskCubit>().getTasks();
//   //   super.didChangeDependencies();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text(
//           'Logo',
//           style: TextStyle(),
//         ),
//         actions: [
//           GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ProfileScreen()),
//                 );
//               },
//               child:
//                   // const Icon(Icons.person, size: 30, color: AppColors.mainColor),
//                   SvgPicture.asset(
//                 'assets/svgs/Frame.svg',
//                 color: Colors.black,
//                 width: 24,
//                 height: 24,
//               )),
//           const SizedBox(width: 16),
//           GestureDetector(
//             onTap: () {
//               AuthLocalDatasorce().clearTokens();

//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginScreenView()),
//                 (Route<dynamic> route) => false,
//               );
//             },
//             child: const Icon(Icons.logout, color: AppColors.mainColor),
//           ),
//           const SizedBox(width: 20),
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             heroTag: "Qr",
//             elevation: 1,
//             backgroundColor: AppColors.LightPurple,
//             child: Icon(
//               Icons.qr_code,
//               color: AppColors.mainColor,
//             ),
//             onPressed: () async {
//               await Navigator.push<String>(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const QRScannerScreen()),
//               );
//             },
//             shape: const CircleBorder(),
//           ),
//           const SizedBox(height: 12),
//           FloatingActionButton(
//             heroTag: "Add",
//             backgroundColor: AppColors.mainColor,
//             elevation: 1,
//             child: const Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const AddNewTask(
//                     isEdit: false,
//                   ),
//                 ),
//               );
//             },
//             shape: const CircleBorder(),
//           ),
//         ],
//       ),
//       body: DefaultTabController(
//         length: list.length,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "My Tasks",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               height: 40,
//               child: TabBar(
//                   isScrollable: false,
//                   tabAlignment: TabAlignment.center,
//                   dividerHeight: 0,
//                   labelColor: Colors.white,
//                   indicator: BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                   unselectedLabelColor: AppColors.FontGray,
//                   indicatorSize: TabBarIndicatorSize.label,
//                   onTap: (index) {
//                     setState(() {
//                       selectedItem = list[index]["value"]!;
//                       selectedIndex = index;
//                       context.read<TaskCubit>().getTasks(status: selectedItem);
//                     });
//                   },
//                   // tabs: [
//                     Tab(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 18, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: selectedIndex == 0
//                               ? AppColors.mainColor
//                               : AppColors.LightPurple,
//                           borderRadius: BorderRadius.circular(24),
//                         ),
//                         margin: EdgeInsets.symmetric(horizontal: 2),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Text(list[0]["label"] ?? "",
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w700, fontSize: 16)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Tab(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 18, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: selectedIndex == 1
//                               ? AppColors.mainColor
//                               : AppColors.LightPurple,
//                           borderRadius: BorderRadius.circular(24),
//                         ),
//                         margin: EdgeInsets.symmetric(horizontal: 2),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Text(list[1]["label"] ?? "",
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 16)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Tab(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 18, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: selectedIndex == 2
//                               ? AppColors.mainColor
//                               : AppColors.LightPurple,
//                           borderRadius: BorderRadius.circular(24),
//                         ),
//                         margin: EdgeInsets.symmetric(horizontal: 2),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Text(list[2]["label"] ?? "",
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 14)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Tab(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 18, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: selectedIndex == 3
//                               ? AppColors.mainColor
//                               : AppColors.LightPurple,
//                           borderRadius: BorderRadius.circular(24),
//                         ),
//                         margin: EdgeInsets.symmetric(horizontal: 2),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Text(list[3]["label"] ?? "",
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 16)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ]),
//             ),

//             const SizedBox(height: 12),
//             Expanded(
//               child: BlocBuilder<TaskCubit, TodoState>(
//                 builder: (context, state) {
//                   if (state is LoadingState) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (state is ErrorState) {
//                     return const Center(child: Text("Error loading tasks"));
//                   } else if (state is LoadedState) {
//                     final tasks = state.tasks;

//                     // ? state.tasks
//                     // : state.tasks
//                     //     .where((task) => task.state == selectedItem)
//                     //     .toList();

//                     if (tasks.isEmpty) {
//                       return const Center(child: Text("No tasks found"));
//                     }

//                     return ListView.builder(
//                       itemCount: tasks.length,
//                       itemBuilder: (context, index) => GestureDetector(
//                         behavior: HitTestBehavior.translucent, //  مفيدددة جدا
//                         child: TaskItem(task: tasks[index]),
//                         onTap: () {},
//                       ),
//                     );
//                   } else {
//                     return const SizedBox();
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/utilities/app_colors.dart';
import 'package:todo_app/features/auth/data_layer/data_source/auth_local_datasorce.dart';
import 'package:todo_app/features/auth/presentation_layer/screens/login_screen_view.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_state.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/qr_scanner_screen.dart';
import '../widget/task_item.dart';
import 'add_task/add_new_task.dart';
import '../../../profile/presntation/screen/profile_screen.dart';

BuildContext? mainContext;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  // List<Map<String, String>> list = [
  //   {"label": "All", "value": "all"},
  //   {"label": "InProgress", "value": "inProgress"},
  //   {"label": "Waiting", "value": "waiting"},
  //   {"label": "Finished", "value": "finished"},
  // ];

  // List<Map<String, String>> list = [
  //   {"label": "All", "value": "all"},
  //   {"label": "InProgress", "value": "inProgress"},
  //   {"label": "Waiting", "value": "waiting"},
  //   {"label": "Finished", "value": "finished"},
  // ];

  List<String> list = [
    "All",
    "InProgress",
    "Waiting",
    "Finished",
  ];

  String selectedItem = "";
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    mainContext = context;
    selectedItem = list[0];
    // تحميل الصفحة الأولى للفلتر الافتراضي
    context.read<TaskCubit>().getTasks(status: selectedItem.toLowerCase());

    // إنشاء ScrollController
    _scrollController = ScrollController();

    //  إذا اقترب المستخدم من نهاية القائمة، اطلب تحميل المزيد
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // استدعاء تحميل المزيد مع تمرير isLoadMore = true
        context.read<TaskCubit>().getTasks(
              status: selectedItem.toLowerCase(),
              isLoadMore: true,
            );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // هنا تضعها لتنظيف الـ controller
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   context.read<TaskCubit>().getTasks();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Logo',
          style: TextStyle(),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              child:
                  // const Icon(Icons.person, size: 30, color: AppColors.mainColor),
                  SvgPicture.asset(
                'assets/svgs/Frame.svg',
                color: Colors.black,
                width: 24,
                height: 24,
              )),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              AuthLocalDatasorce().clearTokens();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginScreenView()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Icon(Icons.logout, color: AppColors.mainColor),
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
            backgroundColor: AppColors.LightPurple,
            child: Icon(
              Icons.qr_code,
              color: AppColors.mainColor,
            ),
            onPressed: () async {
              await Navigator.push<String>(
                context,
                MaterialPageRoute(
                    builder: (context) => const QRScannerScreen()),
              );
            },
            shape: const CircleBorder(),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "Add",
            backgroundColor: AppColors.mainColor,
            elevation: 1,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNewTask(
                    isEdit: false,
                  ),
                ),
              );
            },
            shape: const CircleBorder(),
          ),
        ],
      ),
      body: DefaultTabController(
        length: list.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "My Tasks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < list.length; i++)
                      item(
                          title: list[i],
                          isSelected: list[i] == selectedItem,
                          onTap: () {
                            selectedItem = list[i];
                            setState(() {});

                            String value = selectedItem[0].toLowerCase() +
                                selectedItem.substring(1);
                            // String value = selectedItem.toLowerCase();

                            context.read<TaskCubit>().getTasks(status: value);
                          })
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 40,
            //   child: TabBar(
            //       isScrollable: false,
            //       tabAlignment: TabAlignment.center,
            //       dividerHeight: 0,
            //       labelColor: Colors.white,
            //       indicator: BoxDecoration(
            //         color: Colors.transparent,
            //       ),
            //       unselectedLabelColor: AppColors.FontGray,
            //       indicatorSize: TabBarIndicatorSize.label,
            //       onTap: (index) {
            //         setState(() {
            //           selectedItem = list[index]["value"]!;
            //           selectedIndex = index;
            //           context.read<TaskCubit>().getTasks(status: selectedItem);
            //         });
            //       },
            //       tabs: [
            //         Tab(
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 18, vertical: 10),
            //             decoration: BoxDecoration(
            //               color: selectedIndex == 0
            //                   ? AppColors.mainColor
            //                   : AppColors.LightPurple,
            //               borderRadius: BorderRadius.circular(24),
            //             ),
            //             margin: EdgeInsets.symmetric(horizontal: 2),
            //             child: Row(
            //               mainAxisSize: MainAxisSize.max,
            //               children: [
            //                 Text(list[0]["label"] ?? "",
            //                     style: const TextStyle(
            //                         fontWeight: FontWeight.w700, fontSize: 16)),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Tab(
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 18, vertical: 10),
            //             decoration: BoxDecoration(
            //               color: selectedIndex == 1
            //                   ? AppColors.mainColor
            //                   : AppColors.LightPurple,
            //               borderRadius: BorderRadius.circular(24),
            //             ),
            //             margin: EdgeInsets.symmetric(horizontal: 2),
            //             child: Row(
            //               mainAxisSize: MainAxisSize.max,
            //               children: [
            //                 Text(list[1]["label"] ?? "",
            //                     style: const TextStyle(
            //                         fontWeight: FontWeight.bold, fontSize: 16)),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Tab(
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 18, vertical: 10),
            //             decoration: BoxDecoration(
            //               color: selectedIndex == 2
            //                   ? AppColors.mainColor
            //                   : AppColors.LightPurple,
            //               borderRadius: BorderRadius.circular(24),
            //             ),
            //             margin: EdgeInsets.symmetric(horizontal: 2),
            //             child: Row(
            //               mainAxisSize: MainAxisSize.max,
            //               children: [
            //                 Text(list[2]["label"] ?? "",
            //                     style: const TextStyle(
            //                         fontWeight: FontWeight.bold, fontSize: 14)),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Tab(
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 18, vertical: 10),
            //             decoration: BoxDecoration(
            //               color: selectedIndex == 3
            //                   ? AppColors.mainColor
            //                   : AppColors.LightPurple,
            //               borderRadius: BorderRadius.circular(24),
            //             ),
            //             margin: EdgeInsets.symmetric(horizontal: 2),
            //             child: Row(
            //               mainAxisSize: MainAxisSize.max,
            //               children: [
            //                 Text(list[3]["label"] ?? "",
            //                     style: const TextStyle(
            //                         fontWeight: FontWeight.bold, fontSize: 16)),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ]),
            // ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<TaskCubit, TodoState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ErrorState) {
                    return const Center(child: Text("Error loading tasks"));
                  } else if (state is LoadedState) {
                    final tasks = state.tasks;

                    // ? state.tasks
                    // : state.tasks
                    //     .where((task) => task.state == selectedItem)
                    //     .toList();

                    if (tasks.isEmpty) {
                      return const Center(child: Text("No tasks found"));
                    }

                    return ListView.builder(
                      controller: _scrollController, // ربط الـ ScrollController
                      itemCount:
                          tasks.length + 1, // +1 لإضافة عنصر تحميل في النهاية
                      itemBuilder: (context, index) {
                        if (index < tasks.length) {
                          // عرض المهام
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: TaskItem(task: tasks[index]),
                            onTap: () {},
                          );
                        } else {
                          // عنصر تحميل المزيد أو رسالة لا يوجد المزيد
                          if (context.read<TaskCubit>().hasMore) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: Text("No more tasks")),
                            );
                          }
                        }
                      },
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

  Widget item({
    required String title,
    required bool isSelected,
    required onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : AppColors.LightPurple,
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color:
                        isSelected ? Colors.white : AppColors.FontGrayLight)),
          ],
        ),
      ),
    );
  }
}
