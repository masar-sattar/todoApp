import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/components/network/error_handler/api_error_model.dart';
import 'package:todo_app/features/todo/data_layer/model/task_models.dart';
import 'package:todo_app/features/todo/data_layer/repository/task_repository.dart';
import 'package:todo_app/features/todo/domain_layer/entities/create_task_entites.dart';

import '../../domain_layer/repository/base_task_repository.dart';
import 'todo_state.dart';

class TaskCubit extends Cubit<TodoState> {
  final TaskRepository taskrepo;

  TaskCubit(this.taskrepo) : super(InitialState());

  CreateTaskEntites? createTask = CreateTaskEntites();

  XFile? taskImage;
  FormData? taskFormData; // send to backend (API)
  String taskImageResponse = ''; //
//just to choose image
  Future pickTaskImage() async {
    try {
      taskImage = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (taskImage == null) return;

      emit(PickTaskImageState());
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  void clearImage() {
    taskImage = null;
    taskFormData = null;
    taskImageResponse = "";
  }

  // function to upload image
  Future uploadTaskImage() async {
    taskFormData = FormData.fromMap(
      {
        'image': await MultipartFile.fromFile(
          taskImage!.path,
          filename: taskImage!.name,
          contentType: MediaType('image', taskImage!.name.split('.').last),
        ),
      },
    );
    final response = await taskrepo.uploadImage(
      data: taskFormData!,
    );

    response.fold(
      (l) {
        print("ERROR FROM API : ${l.message}");
      },
      (r) {
        createTask!.image = r;

        // SharedPrefences.saveData(key: "accessToken", value: r.accesstoken);
        print("SUCCESS CALLING API");
      },
    );
  }

  Future<void> addTask() async {
    // emit(AddTaskLoadingState());
    try {
      await uploadTaskImage();

      await taskrepo.createTask(
          image: createTask?.image ?? '',
          title: createTask!.title!,
          date: createTask!.date ?? '',
          description: createTask!.descrption!,
          priority: createTask!.priority!);

      // await createTask(
      //   image: taskImageResponse,
      //   title: title,
      //   description: description,

      //   // dueDate:date,
      // );

      // emit(AddTaskSuccessState());
    } on ApiErrorModel catch (error) {
      print(error.message);
      // emit(AddTaskFailState());
    }
  }

// createTask
//   Future<void> createTask({
//     required String image,
//     required String title,
//     required String description,
//     // required String date,
//   }) async {
//     final response = await baseTaskRepository.createTask(
//       image: image,
//       title: title,
//       description: description,
//     );
//     response.fold(
//       (l) => throw l,
//       (r) => print("Task Created"),
//     );
//   }

  Future<void> getTasks({int page = 1}) async {
    //here we fetch the data from the repository
    final response = await taskrepo.getTasks();

    // you can check if the server returned an error

    emit(LoadedState(tasks: response));
  }

  Future<void> deleteTask(String taskId) async {
    //here we fetch the data from the repository
    final response = await taskrepo.deleteTask(taskId: taskId);

    // you can check if the server returned an error

    // emit(LoadedState(tasks: response));
  }

  Future<void> getOneTask(String id) async {
    final response = await taskrepo.getOneTask(id);
    emit(LoadedOneTask(oneTask: response));
  }
}
