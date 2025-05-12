import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/componnet/text_component.dart';

import '../../../../components/utilities/app_colors.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_state.dart';
import '../widget/date_pick.dart';
import 'home_screen.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descptionController = TextEditingController();
  @override
  void initState() {
    context.read<TaskCubit>().clearImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new Task')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
                            onTap: () => context.read<TaskCubit>().pickTaskImage(),
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
            const TextComponent(
              hintText: 'Enter description here...',
              maxLines: 5,
            ),
            const SizedBox(height: 20),

            const Text('Priority'),
            const SizedBox(height: 8),
            // const PriorityDropdown(),
            const SizedBox(height: 20),

            const Text('Due date'),
            const SizedBox(height: 8),
            DatePick(),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  context.read<TaskCubit>().addTask(
                        title: titleController.text,
                        description: "",

                      );
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                  //   (route) => false,
                  // );
                },
                child: const Text('Add task',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
