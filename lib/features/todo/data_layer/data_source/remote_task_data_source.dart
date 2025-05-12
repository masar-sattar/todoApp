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
  Future<List<TaskModel>> getTasks() {
    // TODO: Replace this with real data fetch - same as above
    return Future.value([
      TaskModel(image: 'image', date: '2 hours ago', title: 'title', description: 'description', priority: 'priority',state: 'state')
    ]);
  }
  @override
  Future<void> createTask(TaskModel task) async {
    try {
      final response = await DioHelper.postData(
        endPoint: "/tasks",
        body: task.toJson(),
      );

      if (response.statusCode != 201) {
        throw ApiErrorModel.fromJson(response.data);
      }
    } catch (error) {
      throw ApiErrorModel(message: error.toString());
    }
  }

}
