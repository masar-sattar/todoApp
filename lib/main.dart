import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/utilities/theme.dart';
import 'package:todo_app/features/auth/data_layer/data_source/auth_local_datasorce.dart';
import 'package:todo_app/features/auth/data_layer/data_source/auth_remote_data_source.dart';
import 'package:todo_app/features/auth/data_layer/repository/auth_repository.dart';
import 'package:todo_app/features/auth/presentation_layer/cubit/auth_cubit.dart';
import 'package:todo_app/features/auth/presentation_layer/screens/login_screen_view.dart';
import 'package:todo_app/features/auth/presentation_layer/screens/splash_screen.dart';

// import 'package:todo_app/features/auth/presentation_layer/screens/register_screen_view.dart';
// import 'package:todo_app/features/auth/presentation_layer/screens/login_screen_view.dart';

import 'components/bloc_observer/bloc_observer.dart';
import 'features/todo/data_layer/data_source/remote_task_data_source.dart';
import 'features/todo/data_layer/repository/task_repository.dart';
import 'features/todo/presentation_layer/cubit/todo_cubit.dart';
import 'features/todo/presentation_layer/screens/home_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TaskCubit(TaskRepository(RemoteTaskDataSource())),
        ),
        BlocProvider(
            create: (context) => AuthCubit(AuthRepository(
                dataSource: AuthRemoteDataSource(),
                authLocalDatasorce: AuthLocalDatasorce())))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        // home: const DetailsScreen(),
        home: SplashScreen(),
      ),
    );
  }
}
