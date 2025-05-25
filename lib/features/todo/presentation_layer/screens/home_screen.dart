import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/utilities/app_colors.dart';

import 'package:todo_app/features/auth/presentation_layer/screens/login_screen_view.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_state.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/details_screen.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/qr_scanner_screen.dart';

import '../widget/task_item.dart';
import 'add_task/add_new_task.dart';
import '../../../profile/presntation/screen/profile_screen.dart';

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

  // void _openTaskDetails(String taskId) async {
  //   try {
  //     final task = await context.read<TaskCubit>().getOneTask(taskId);

  //     if (!mounted) return;

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => DetailsScreen(id: task.id),
  //       ),
  //     );
  //   } catch (e) {
  //     if (!mounted) return;

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: ${e.toString()}')),
  //     );
  //   }
  // }

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
            mini: true,
            backgroundColor: AppColors.lightPurpleColor,
            child: Icon(
              Icons.qr_code,
              color: AppColors.mainColor,
            ),
            onPressed: () async {
              final scannedId = await Navigator.push<String>(
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
            child: const Icon(Icons.add),
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
                        onTap: () {},
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
