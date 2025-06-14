import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:todo_app/core/utilities/app_colors.dart';

import 'package:todo_app/features/auth/presentation_layer/screens/register_screen_view.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/home_screen.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? phoneNumber;
  String? password;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => AuthCubit(
    //     AuthRepository(
    //       dataSource: AuthRemoteDataSource(),
    //       authLocalDatasorce: AuthLocalDatasorce(),
    //     ),
    //   ),
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthLoadedState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
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
                    const SizedBox(width: 326),
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: IntlPhoneField(
                        validator: (phone) {
                          if (phone == null || phone.number.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (phone.number.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onChanged: (phone) {
                          phoneNumber = phone.completeNumber;
                        },
                        onSaved: (phone) {
                          phoneNumber = phone?.completeNumber;
                        },

                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        languageCode: "en",
                        initialCountryCode: "IQ",
                        // onChanged: (phone) {
                        //   print(phone.completeNumber);
                        // },
                        // onCountryChanged: (country) {
                        //   print('Country changed to: ${country.name}');
                        // },
                        // onSaved: (phone) {
                        //   phoneNumber = phone?.completeNumber;
                        // },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     labelText: 'Password',

                    //     border: OutlineInputBorder(

                    //       borderRadius: BorderRadius.circular(10),
                    //     ),

                    //   ),
                    //   obscureText: true,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your password';
                    //     }
                    //     return null;
                    //   },
                    //   onSaved: (value) {
                    //     password = value;
                    //   },
                    // ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value;
                      },
                    ),

                    const SizedBox(height: 20),
                    BlocBuilder<AuthCubit, AuthStates>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: state is AuthloadingState
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      print("Phone: $phoneNumber");
                                      print("Password: $password");

                                      context.read<AuthCubit>().loginUser(
                                            phone: phoneNumber!,
                                            password: password!,
                                          );
                                    }
                                  },
                            child: state is AuthloadingState
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn’t have any account?",
                              style: TextStyle(
                                color: AppColors.NormaltGray,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              " Sign Up here",
                              style: TextStyle(
                                color: AppColors.mainColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
