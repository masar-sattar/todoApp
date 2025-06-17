import 'package:todo_app/features/todo/data_layer/model/task_models.dart';

class TodoState {}

class InitialState extends TodoState {}

class PickTaskImageState extends TodoState {}

class LoadingState extends TodoState {}

class LoadedState extends TodoState {
  final List<TaskModel> tasks;
  final bool isloading;
  final bool isFirstLoading;

  LoadedState({
    required this.isFirstLoading,
    required this.isloading,
    required this.tasks,
  });
}

class ErrorState extends TodoState {
  final String message;
  ErrorState(this.message);

  List<Object?> get props => [message];
}

class LoadedOneTask extends TodoState {
  final TaskModel oneTask;

  LoadedOneTask({required this.oneTask});
}

class LoadingMoreState extends TodoState {
  final List<TaskModel> tasks;

  LoadingMoreState({required this.tasks});
}


// class TaskPriorityUpdated extends TodoState{}
// class EmptyState extends TodoState {}

