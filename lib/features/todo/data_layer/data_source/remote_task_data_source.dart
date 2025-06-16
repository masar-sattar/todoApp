import 'package:dio/dio.dart';
import 'package:todo_app/core/network/error_handler/api_error_model.dart';
import 'package:todo_app/features/todo/data_layer/model/task_models.dart';

import '../../../../core/network/dio_helper.dart';
import 'base_remote_task_data_source.dart';

class RemoteTaskDataSource extends BaseRemoteTaskDataSource {
  @override
  Future<String> uploadImage({
    required FormData data,
  }) async {
    final response = await DioHelper.postData(
      endPoint: "/upload/image",
      body: data,
    ).catchError((error) {
      /// catch Error for dio exceptions
      throw ApiErrorModel(message: error.toString());
    });

    /// handle server response
    if (response.statusCode == 201) {
      return response.data['image'];
    } else {
      throw ApiErrorModel.fromJson(response.data);
    }
  }

  @override
  // Future<List<TaskModel>> getTasks(String status) async {
  //   List<TaskModel> tasks = [];
  //   try {
  //     final response = await DioHelper.getData(
  //         endPoint: "/todos", query: status == "all" ? {} : {"status": status});

  //     final data = response.data;
  //     // print(data);

  //     for (int i = 0; i < data.length; i++) {
  //       tasks.add(TaskModel.fromJson(data[i]));
  //     }

  //     if (response.statusCode != 200) {
  //       throw ApiErrorModel.fromJson(response.data);
  //     }
  //   } catch (error) {
  //     throw ApiErrorModel(message: error.toString());
  //   }

  //   return tasks;
  // }
  @override
  Future<List<TaskModel>> getTasks(String status, int page) async {
    List<TaskModel> tasks = [];

    try {
      final query = {
        if (status != "all") "status": status,
        "page": page.toString(),
      };

      final response =
          await DioHelper.getData(endPoint: "/todos", query: query);

      if (response.statusCode != 200) {
        throw ApiErrorModel.fromJson(response.data);
      }

      final data = response.data;

      if (data is! List<dynamic>) {
        throw ApiErrorModel(message: "Invalid data format");
      }

      for (var item in data) {
        tasks.add(TaskModel.fromJson(item));
      }
    } catch (error) {
      throw ApiErrorModel(message: error.toString());
    }

    return tasks;
  }

  @override
  Future<void> createTask(TaskModel task) async {
    try {
      final response = await DioHelper.postData(
        endPoint: "/todos",
        body: task.toJson(),
      );

      if (response.statusCode != 201) {
        throw ApiErrorModel.fromJson(response.data);
      }
    } catch (error) {
      throw ApiErrorModel(message: error.toString());
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await DioHelper.deleteData(
        endPoint: "/todos/$taskId",
      );
    } catch (error) {
      throw ApiErrorModel(message: error.toString());
    }
  }

  @override
  Future<TaskModel> getOneTask(String id) async {
    try {
      final response = await DioHelper.getData(
        endPoint: "/todos/$id",
      );

      return TaskModel.fromJson(response.data);
    } catch (error) {
      throw ApiErrorModel(message: error.toString());
    }
  }

  @override
  Future<void> updateTask({
    required String id,
    required TaskModel task,
  }) async {
    try {
      final response = await DioHelper.putData(
        endPoint: "/todos/$id",
        body: task.toJson(),
      );

      if (response.statusCode != 200) {
        throw ApiErrorModel(message: "Failed to update task");
      }
    } catch (error) {
      if (error is DioException) {
        throw ApiErrorModel(
            message: error.response?.data["message"] ?? "Unknown error");
      } else {
        throw ApiErrorModel(message: error.toString());
      }
    }
  }
}
