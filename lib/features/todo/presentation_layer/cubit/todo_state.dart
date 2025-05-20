import 'package:todo_app/features/todo/data_layer/model/task_models.dart';

class TodoState {}

class InitialState extends TodoState {}

class PickTaskImageState extends TodoState {}

class LoadingState extends TodoState {}

class LoadedOneTask extends TodoState {
  final TaskModel oneTask;

  LoadedOneTask({required this.oneTask});
}

class LoadedState extends TodoState {
  final List<TaskModel> tasks;

  LoadedState({
    required this.tasks,
  });
//   final List<Todo> todos;
//   final bool hasReachedMax;
//
//    LoadedState({required this.todos, required this.hasReachedMax});
//
//   LoadedState copyWith({
//     List<Todo>? todos,
//     bool? hasReachedMax,
//   }) {
//     return LoadedState(
//       todos: todos ?? this.todos,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//     );
//   }
//
//   @override
//   List<Object?> get props => [todos, hasReachedMax];
}

class ErrorState extends TodoState {
  final String message;
  ErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

// class TaskPriorityUpdated extends TodoState{}
class EmptyState extends TodoState {}
