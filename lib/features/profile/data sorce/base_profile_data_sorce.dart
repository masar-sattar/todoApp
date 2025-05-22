import 'package:todo_app/features/profile/data%20layer/profile_model/profile_model.dart';

abstract class BaseProfileDataSorce {
  Future<UserModel> getProfile();
}
