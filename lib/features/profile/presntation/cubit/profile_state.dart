import 'package:todo_app/features/profile/data%20layer/profile_model/profile_model.dart';

class ProfileState {}

class InitialState extends ProfileState {}

class LoadingProfile extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  ProfileLoaded({required this.user});
}
