import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../components/network/error_handler/api_error_model.dart';
import '../../domain_layer/repository/base_task_repository.dart';
import '../data_source/remote_task_data_source.dart';
import '../model/task_models.dart';

class TaskRepository extends BaseTaskRepository {
  final RemoteTaskDataSource dataSource;

  TaskRepository(this.dataSource);

  @override
  Future<Either<ApiErrorModel, String>> uploadImage({
    required FormData data,
  }) async {
    // call data source to fetch data from server
    try {
      final response = await dataSource.uploadImage(data: data);

      return Right(response);
    } on ApiErrorModel catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> createTask({
    required String image,
    required String title,
    required String date,
    required String description,
    required String priority,
    required String? state,
  }) async {
    try {
      final response = await dataSource.createTask(TaskModel(
          id: "",
          image: image,
          date: "",
          title: title,
          description: description,
          priority: priority,
          state: ""));

      return Right(response);
    } on ApiErrorModel catch (error) {
      return Left(error);
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    return await dataSource.getTasks();
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    try {
      await dataSource.deleteTask(taskId);
    } on ApiErrorModel catch (error) {
      print("Error: $error");
    }
  }

  @override
  Future<TaskModel> getOneTask(String id) async {
    return await dataSource.getOneTask(id);
  }

  @override
  Future<void> updateTask({
    required String id,
    required String image,
    required String title,
    required String date,
    required String description,
    required String priority,
    required String state,
  }) async {
    try {
      await dataSource.updateTask(
        id: id,
        task: TaskModel(
          id: id,
          image: image,
          date: date,
          title: title,
          description: description,
          priority: priority,
          state: state, // أو استخدم القيمة الحالية إن كانت متوفرة
        ),
      );
    } on ApiErrorModel catch (e) {
      rethrow;
    }
  }
}
