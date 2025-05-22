import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:todo_app/features/todo/data_layer/model/task_models.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_state.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TaskModel? detailsitem;
  @override
  initState() {
    super.initState();
    getOneTask();
  }

  void getOneTask() async {
    final result = await context.read<TaskCubit>().getOneTask(widget.id);
    setState(() {
      detailsitem = result;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                child: Text('edit'),
              ),
              PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
                onTap: () async {
                  await context.read<TaskCubit>().deleteTask(widget.id);

                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('sucess'),
                        content: Text('Delete done'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                            child: Text('ok'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: detailsitem == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        detailsitem!.image,
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      detailsitem!.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      detailsitem!.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEFE6FF),
                        hintText: "End Date",
                        suffixIcon:
                            Icon(Icons.calendar_month, color: Colors.purple),
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
                        suffixIcon:
                            Icon(Icons.arrow_drop_down, color: Colors.purple),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      readOnly: true,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.flag_outlined,
                          color: Colors.deepPurple,
                        ),
                        filled: true,
                        fillColor: Color(0xFFEFE6FF),
                        hintText: detailsitem!.priority,
                        suffixIcon:
                            Icon(Icons.arrow_drop_down, color: Colors.purple),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      readOnly: true,
                      onTap: () {},
                    ),
                    Center(
                      child: QrImageView(
                        data: detailsitem!.id,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
