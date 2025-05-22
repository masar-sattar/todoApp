import 'package:todo_app/features/profile/data%20layer/profile_model/profile_model.dart';
import 'package:todo_app/features/profile/data%20sorce/remote_profile_data_sorce.dart';
import 'package:todo_app/features/profile/domain%20layer/repository/base_profile_repository.dart';

class ProfileRepositry extends BaseProfileRepository {
  final RemoteProfileDataSorce dataprofile;

  ProfileRepositry({required this.dataprofile});
  Future<UserModel> getProfile() async {
    return await dataprofile.getProfile();
  }
}
