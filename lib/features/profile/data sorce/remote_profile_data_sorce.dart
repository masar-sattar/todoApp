import 'package:todo_app/components/network/dio_helper.dart';
import 'package:todo_app/components/network/error_handler/api_error_model.dart';
import 'package:todo_app/features/profile/data%20layer/profile_model/profile_model.dart';
import 'package:todo_app/features/profile/data%20sorce/base_profile_data_sorce.dart';

class RemoteProfileDataSorce extends BaseProfileDataSorce {
  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await DioHelper.getData(
        endPoint: "/auth/profile",
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ApiErrorModel.fromJson(response.data);
      }
    } catch (error) {
      throw ApiErrorModel(message: error.toString());
    }
  }
}
