import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data_layer/data_source/auth_remote_data_source.dart';
import '../../data_layer/repository/auth_repository.dart';
import '../../domain_layer/entities/register_body.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  // login function

  // register function
  Future registerUser({
    required RegisterBody registerBody,
  }) async {
    // call register function from base repository (domain layer)
    final AuthRepository authRepository = AuthRepository(
      dataSource: AuthRemoteDataSource(),
    );

    final response = await authRepository.registerUser(
      registerBody: registerBody,
    );

    response.fold(
      (l) {
        print("ERROR FROM API : ${l.message}");
      },
      (r) {
        print(r.accesstoken);
        print(r.refreshtoken);
        // SharedPrefences.saveData(key: "accessToken", value: r.accesstoken);
        print("SUCCESS CALLING API");
      },
    );
  }

  // level of experience
  String? selectedItem;
  // Stores selected value
  List<String> items = ["fresh", "junior", "midLevel", "senior"];

  void selectLevelExperience(String? level) {
    selectedItem = level;
    emit(LevelSelectedState());
  }
}
