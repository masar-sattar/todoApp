import 'package:dio/dio.dart';
import 'package:todo_app/features/todo/data_layer/model/task_models.dart';

abstract class BaseRemoteTaskDataSource {
  Future<String> uploadImage({
    required FormData data,
  });

  Future<List<TaskModel>> getTasks(String status, int page);

  Future<void> createTask(TaskModel task);

  Future<void> deleteTask(String taskId);

  Future<TaskModel> getOneTask(String id);

  Future<void> updateTask({
    required String id,
    required TaskModel task,
  });
}
