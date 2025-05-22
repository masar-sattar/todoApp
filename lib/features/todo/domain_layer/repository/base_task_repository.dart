import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation_layer/widget/task_item.dart';

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
  });

  Future<List<TaskModel>> getTasks();
  Future<void> deleteTask({
    required String taskId,
  });
  Future<TaskModel> getOneTask(String id);
  // Future<void> updateTask();
}
