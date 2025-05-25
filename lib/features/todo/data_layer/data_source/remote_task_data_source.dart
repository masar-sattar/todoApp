import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo_app/components/network/error_handler/api_error_model.dart';
import 'package:todo_app/features/todo/data_layer/model/task_models.dart';

import '../../../../components/network/dio_helper.dart';
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
  Future<List<TaskModel>> getTasks() async {
    // TODO: Replace this with real data fetch - same as above

    List<TaskModel> tasks = [];
    try {
      final response = await DioHelper.getData(
        endPoint: "/todos",
      );
      final data = response.data;
      // print(data);

      for (int i = 0; i < data.length; i++) {
        tasks.add(TaskModel.fromJson(data[i]));
      }

      if (response.statusCode != 200) {
        throw ApiErrorModel.fromJson(response.data);
      }
    } catch (error) {
      print('hell error');
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
      final response = await DioHelper.deleteData(
        endPoint: "/todos/$taskId",
      );
    } catch (error) {
      throw ApiErrorModel(message: error.toString());
    }
  }

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
