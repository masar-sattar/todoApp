import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/features/profile/data%20layer/repositry/profile_repositry.dart';
import 'package:todo_app/features/profile/presntation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepositry profileRepo;

  ProfileCubit(this.profileRepo) : super(InitialState());

  Future<void> getProfile() async {
    emit(LoadingProfile());
    final response = await profileRepo.getProfile();
    emit(ProfileLoaded(user: response));
  }
}
