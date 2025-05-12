import 'package:dio/dio.dart';
import 'package:todo_app/features/todo/data_layer/model/task_models.dart';

abstract class BaseRemoteTaskDataSource {
  Future<String> uploadImage({
    required FormData data,
  });

  Future<List<TaskModel>> getTasks();
@override
  Future<void> createTask(TaskModel task);
}