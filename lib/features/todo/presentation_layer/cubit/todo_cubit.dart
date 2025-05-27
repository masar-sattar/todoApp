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
    // final x = state;

    emit(LoadingState());
    if (createTask == null ||
        createTask!.date == null ||
        createTask!.date!.isEmpty) {
      emit(ErrorState("plz add date"));
      return; // لا تكمل الإضافة إذا التاريخ غير موجود
    }

    try {
      await uploadTaskImage();

      await taskrepo.createTask(
        image: createTask?.image ?? '',
        title: createTask!.title!,
        date: createTask!.date ?? '',
        description: createTask!.descrption!,
        priority: createTask!.priority!,
        state: createTask!.state,
      );
      // emit(x);
    } on ApiErrorModel catch (error) {
      print(error.message);
    }
  }

  Future<void> getTasks({int page = 1}) async {
    //here we fetch the data from the repository

    emit(LoadingState());
    final response = await taskrepo.getTasks();
    print('Hello massar');

    // you can check if the server returned an error

    emit(LoadedState(tasks: response));
  }

  Future<void> deleteTask(String taskId) async {
    //here we fetch the data from the repository
    await taskrepo.deleteTask(taskId: taskId);
    getTasks();
    // you can check if the server returned an error

    // emit(LoadedState(tasks: response));
  }

  Future<TaskModel> getOneTask(String id) async {
    final response = await taskrepo.getOneTask(id);
    emit(LoadedOneTask(oneTask: response));
    return response;
  }

  Future<bool> updateTask(String taskId) async {
    emit(LoadingState());

    if (taskImage != null) {
      await uploadTaskImage();
    }

    await taskrepo.updateTask(
      id: taskId,
      title: createTask!.title!,
      description: createTask!.descrption!,
      priority: createTask!.priority!,
      date: createTask!.date!,
      image: createTask!.image ?? "",
      state: createTask?.state ?? "",
    );
    return true;
  }
}
