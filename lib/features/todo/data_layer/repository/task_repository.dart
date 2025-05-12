import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../components/network/error_handler/api_error_model.dart';
import '../../domain_layer/repository/base_task_repository.dart';
import '../data_source/base_remote_task_data_source.dart';
import '../model/task_models.dart';

class TaskRepository extends BaseTaskRepository {
  final BaseRemoteTaskDataSource dataSource;

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
  Future<Either<ApiErrorModel, void>> createTask(
      {required String image,
      required String title,
      required String description}) {
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    // TODO: implement getTasks
    return await dataSource.getTasks();
  }
// }
// @override
// Future<Either<ApiErrorModel, void>> createTask({
//   required String date,
//   required String image,
//   required String title,
//   required String description,
// }) async {
//   try {
//     await dio.post(
//       'your_api_endpoint/todo',
//       data: {
//         "due_date": date,
//         "image": image,
//         "title": title,
//         "description": description,
//       },
//     );
//     return Right(null);
//   } catch (e) {
//     return Left(ApiErrorModel.fromDioError(e));
//   }
// }
}
