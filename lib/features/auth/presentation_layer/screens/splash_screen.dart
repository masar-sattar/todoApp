import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/presentation_layer/cubit/auth_cubit.dart';
import 'package:todo_app/features/auth/presentation_layer/screens/login_screen_view.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    taregtUser();
  }

  void taregtUser() async {
    final isAuth = await context.read<AuthCubit>().isAuth();

    if (isAuth) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreenView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Text('splash'),
      ),
    );
  }
}
