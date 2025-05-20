import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/data_layer/model/task_models.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_state.dart';

class DetailsScreen extends StatelessWidget {
  final TaskModel detailsitem;
  final String id;
  const DetailsScreen({super.key, required this.detailsitem, required this.id});
  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().getOneTask(id);
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
                  await context.read<TaskCubit>().deleteTask(id);
                  context.read<TaskCubit>().getTasks();
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
      body: BlocBuilder<TaskCubit, TodoState>(
        builder: (context, state) {
          if (state is LoadedOneTask) {
            final task = state.oneTask;

            return Padding(
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
                        detailsitem.image,
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      detailsitem.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      detailsitem.description,
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
                    Container(
                      width: 340,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xF0EFE6FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            color: Colors.deepPurple,
                          ),
                          Text(
                            detailsitem.priority,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/barcode_image.png')
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
