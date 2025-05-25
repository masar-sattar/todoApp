import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:todo_app/components/utilities/app_colors.dart';
import 'package:todo_app/features/todo/data_layer/model/task_models.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_state.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/add_task/add_new_task.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:todo_app/components/utilities/app_colors.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_state.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/add_task/add_new_task.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().getOneTask(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<TaskCubit>().getTasks();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Task Details'),
          actions: [
            BlocBuilder<TaskCubit, TodoState>(
              builder: (context, state) {
                if (state is LoadedOneTask) {
                  return PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (String value) {},
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                        onTap: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddNewTask(
                                  isEdit: true,
                                  task: state.oneTask,
                                ),
                              ),
                            );
                          });
                        },
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                        onTap: () async {
                          await context.read<TaskCubit>().deleteTask(widget.id);
                          Navigator.pop(context); // خروج من صفحة التفاصيل
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Success'),
                                content: Text('Delete done'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<TaskCubit, TodoState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoadedOneTask) {
              final task = state.oneTask;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          task.image,
                          fit: BoxFit.cover,
                          height: 250,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        task.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        task.description,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFE6FF),
                          hintText: "End Date",
                          suffixIcon: Icon(Icons.calendar_month,
                              color: AppColors.mainColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        readOnly: true,
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFE6FF),
                          hintText: "inprogress",
                          suffixIcon: Icon(Icons.arrow_drop_down,
                              color: AppColors.mainColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        readOnly: true,
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.flag_outlined,
                              color: AppColors.mainColor),
                          filled: true,
                          fillColor: Color(0xFFEFE6FF),
                          hintText: task.priority,
                          suffixIcon: Icon(Icons.arrow_drop_down,
                              color: AppColors.mainColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        readOnly: true,
                        onTap: () {},
                      ),
                      Center(
                        child: QrImageView(
                          data: task.id,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text("No task data found."));
            }
          },
        ),
      ),
    );
  }
}
