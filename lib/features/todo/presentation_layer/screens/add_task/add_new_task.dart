// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/componnet/text_component.dart';
import 'package:todo_app/features/todo/data_layer/model/task_models.dart';
import 'package:todo_app/features/todo/domain_layer/entities/create_task_entites.dart';
import 'package:todo_app/features/todo/presentation_layer/widget/status_dropdown.dart';

import '../../../../../core/utilities/app_colors.dart';
import '../../cubit/todo_cubit.dart';
import '../../cubit/todo_state.dart';
import '../../widget/date_pick.dart';
import '../../widget/priorty_dropdown.dart';

class AddNewTask extends StatefulWidget {
  final TaskModel? task;
  final bool isEdit;

  const AddNewTask({super.key, required this.isEdit, this.task});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().clearImage();

    if (widget.isEdit && widget.task != null) {
      titleController.text = widget.task!.title;
      descptionController.text = widget.task!.description;
      dateController.text = widget.task!.date;

      context.read<TaskCubit>().createTask = CreateTaskEntites(
        title: widget.task!.title,
        descrption: widget.task!.description,
        image: widget.task!.image,
        date: widget.task!.date,
        priority: widget.task!.priority,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEdit ? 'Edit Task' : 'Add Task')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Image
              BlocBuilder<TaskCubit, TodoState>(
                builder: (context, state) {
                  if (context.read<TaskCubit>().taskImage != null) {
                    // user selected image
                    return Container(
                      height: 200,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            File(context.read<TaskCubit>().taskImage!.path),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: GestureDetector(
                              onTap: () =>
                                  context.read<TaskCubit>().pickTaskImage(),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.mainColor,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (widget.isEdit &&
                      widget.task != null &&
                      widget.task!.image.isNotEmpty) {
                    // لا يوجد صورة محلية جديدة، لكن هناك صورة موجودة من المهمة (رابط)
                    return Container(
                      height: 200,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            widget.task!.image,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                              child: Icon(Icons.broken_image,
                                  size: 50, color: Colors.grey),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: GestureDetector(
                              onTap: () {
                                context.read<TaskCubit>().pickTaskImage();
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.mainColor,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: [6, 4],
                      color: Colors.purple,
                      strokeWidth: 2,
                      child: InkWell(
                        onTap: () {
                          context.read<TaskCubit>().pickTaskImage();
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add_photo_alternate_outlined,
                                    color: Colors.purple),
                                SizedBox(width: 8),
                                Text("Add Img",
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),

              const Text('Task title'),
              const SizedBox(height: 8),
              TextComponent(
                controller: titleController,
                hintText: 'Enter title here...',
              ),
              const SizedBox(height: 20),

              const Text('Task Description'),
              const SizedBox(height: 8),
              TextComponent(
                controller: descptionController,
                hintText: 'Enter description here...',
                maxLines: 5,
              ),
              const SizedBox(height: 20),

              const Text('Priority'),

              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: PriorityDropdown(isEdit: widget.isEdit),
              ),
              if (widget.isEdit)
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: StatusDropdown(),
                ),
              const SizedBox(height: 8),

              const Text('Due date'),
              const SizedBox(height: 8),
              DatePick(controller: dateController),

              const SizedBox(height: 30),
              BlocBuilder<TaskCubit, TodoState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      // onPressed: () async {
                      //   if (!_formKey.currentState!.validate()) {
                      //     return;
                      //   }
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        // تحقق من التاريخ
                        if (dateController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill empty field')),
                          );
                          return;
                        }

                        // تحقق من الصورة
                        if (context.read<TaskCubit>().taskImage == null &&
                            widget.isEdit == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please add an image')),
                          );
                          return;
                        }
                        if (context.read<TaskCubit>().createTask?.priority ==
                            null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please  select priorty ')),
                          );
                          return;
                        }

                        final taskCubit = context.read<TaskCubit>();
                        taskCubit.createTask ??= CreateTaskEntites();
                        taskCubit.createTask?.title = titleController.text;
                        taskCubit.createTask?.descrption =
                            descptionController.text;
                        taskCubit.createTask?.date = dateController.text;

                        bool success = false;

                        if (widget.isEdit) {
                          success = await taskCubit.updateTask(widget.task!.id);
                          if (success) {
                            await taskCubit.getOneTask(widget.task!.id);
                          }
                        } else {
                          await taskCubit.addTask();
                          await taskCubit.getTasks();
                        }

                        if (!context.mounted) return;
                        Navigator.pop(context);
                        // }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            widget.isEdit ? 'Update task' : 'Add task',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
