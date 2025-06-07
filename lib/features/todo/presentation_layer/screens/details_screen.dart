// ignore_for_file: duplicate_import, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:todo_app/components/utilities/app_colors.dart';

import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_state.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/add_task/add_new_task.dart';

import 'package:flutter/material.dart';

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewTask(
                                isEdit: true,
                                task: state.oneTask,
                              ),
                            ),
                          );
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
                                            .deleteTask(widget.id);

                                        if (!context.mounted) return;
                                        Navigator.pop(context);

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
                          hintText: task.date.isNotEmpty
                              ? DateFormat("dd/MM/yyyy")
                                  .format(DateTime.parse(task.date))
                              : 'No date',
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
                          hintText: task.state,
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
