// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utilities/app_colors.dart';
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
    // Future.delayed(const Duration(seconds: 4), () {
    //   taregtUser(); // سيتم تنفيذ هذه الدالة بعد 2 ثانية
    // });
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
      backgroundColor: AppColors.mainColor,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/Tasky.png',
              width: 100,
              height: 100,
            ),
            Image.asset(
              'assets/images/y.png',
              width: 40,
              height: 40,
            )
          ],
        ),
      )),
    );
  }
}
