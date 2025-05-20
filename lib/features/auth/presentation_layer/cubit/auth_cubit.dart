import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/data_layer/data_source/auth_local_datasorce.dart';
import '../../data_layer/data_source/auth_remote_data_source.dart';
import '../../data_layer/repository/auth_repository.dart';
import '../../domain_layer/entities/register_body.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  // AuthCubit() : super(AuthInitialState());
  AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitialState());
// isAuth
  Future<bool> isAuth() async {
    return await authRepository.isAuth();
  }

  // login function
  Future<void> loginUser({
    required String phone,
    required String password,
  }) async {
    emit(AuthloadingState());
    final AuthRepository authRepository = AuthRepository(
      dataSource: AuthRemoteDataSource(),
      authLocalDatasorce: AuthLocalDatasorce(),
    );

    final response = await authRepository.loginUser(
      phoneNumber: phone,
      password: password,
    );

    response.fold(
      (failure) {
        emit(AuthErrorState(failure.message));

        print("ERROR FROM API : ${failure.message}");
      },
      (authModel) {
        print("SUCCESS: ${authModel.accesstoken}");
        print("REFRESH: ${authModel.refreshtoken}");
        // SharedPrefences.saveData(key: "accessToken", value: authModel.accesstoken);
        emit(AuthLoadedState());
      },
    );
  }

  // register function
  Future registerUser({
    required RegisterBody registerBody,
  }) async {
    // call register function from base repository (domain layer)
    final AuthRepository authRepository = AuthRepository(
      dataSource: AuthRemoteDataSource(),
      authLocalDatasorce: AuthLocalDatasorce(),
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
