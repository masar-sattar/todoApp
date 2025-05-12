import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:todo_app/features/auth/presentation_layer/screens/register_screen_view.dart';

import '../../../todo/presentation_layer/screens/home_screen.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/login_image.png',
                      fit: BoxFit.cover,
                      // height: 250,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    languageCode: "en",
                    initialCountryCode: "IQ",
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ${country.name}');
                    },
                  ),
                  const SizedBox(height: 10),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     labelText: 'user name ',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthCubit, AuthStates>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {
                            print("Sign In Pressed");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const RegisterScreenView();
                          },
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        "Don't have an account? Sign Up here",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
