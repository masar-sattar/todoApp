abstract class AuthStates {}

class AuthInitialState extends AuthStates {}
class AuthloadingState extends AuthStates{}
class AuthLoadedState extends AuthStates{}
class LevelSelectedState extends AuthStates {}
class AuthErrorState extends AuthStates {
  final String message;
  AuthErrorState(this.message);
}
