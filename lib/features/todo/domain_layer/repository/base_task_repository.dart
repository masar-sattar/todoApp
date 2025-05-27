import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../components/network/error_handler/api_error_model.dart';
import '../../data_layer/model/task_models.dart';

abstract class BaseTaskRepository {
  Future<Either<ApiErrorModel, String>> uploadImage({
    required FormData data,
  });

  Future<Either<ApiErrorModel, void>> createTask({
    required String image,
    required String title,
    required String description,
    required String date,
    required String priority,
    required String? state,
  });

  Future<List<TaskModel>> getTasks();
  Future<void> deleteTask({
    required String taskId,
  });
  Future<TaskModel> getOneTask(String id);
  Future<void> updateTask({
    required String id,
    required String title,
    required String description,
    required String date,
    required String image,
    required String priority,
    required String state,
  });
}
