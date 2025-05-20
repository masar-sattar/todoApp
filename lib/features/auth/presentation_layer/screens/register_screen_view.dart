import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:todo_app/features/auth/data_layer/repository/auth_repository.dart';
import 'package:todo_app/features/auth/domain_layer/entities/register_body.dart';
import 'package:todo_app/features/auth/presentation_layer/cubit/auth_states.dart';
import 'package:todo_app/features/auth/presentation_layer/widgets/level_dropdown.dart';
import 'package:todo_app/components/componnet/text_component.dart';
import 'package:todo_app/features/auth/data_layer/data_source/auth_remote_data_source.dart';
import 'package:todo_app/features/auth/data_layer/data_source/auth_local_datasorce.dart';
import 'package:todo_app/features/auth/data_layer/data_source/auth_local_datasorce.dart';

import '../cubit/auth_cubit.dart';

class RegisterScreenView extends StatefulWidget {
  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController displayName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController experienceYears = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();

  String? selectedCountryCode = "+964";
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AuthCubit(
        AuthRepository(
            dataSource: AuthRemoteDataSource(),
            authLocalDatasorce: AuthLocalDatasorce()),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              autovalidateMode: autovalidateMode,
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
                  const SizedBox(height: 30),
                  TextComponent(
                    controller: displayName,
                    labelField: 'name',
                  ),
                  const SizedBox(height: 30),
                  IntlPhoneField(
                    controller: phoneNumber,
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
                      print('Country changed to: ' "+${country.dialCode}");
                      selectedCountryCode = "+${country.dialCode}";
                    },
                  ),
                  const SizedBox(height: 30),
                  TextComponent(
                    controller: experienceYears,
                    labelField: 'experence years',
                  ),
                  const SizedBox(height: 30),
                  const LevelDropdown(),
                  const SizedBox(height: 30),
                  TextComponent(
                    controller: address,
                    labelField: 'address',
                  ),
                  const SizedBox(height: 30),
                  TextComponent(
                    controller: password,
                    labelField: 'password',
                  ),
                  const SizedBox(height: 30),
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
                            if (formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Form Submitted Successfully!")),
                              );
                            }
                            print(context.read<AuthCubit>().selectedItem);

                            /// call register fuction from cubit
                            context.read<AuthCubit>().registerUser(
                                  registerBody: RegisterBody(
                                    displayName: displayName.text,
                                    years:
                                        int.tryParse(experienceYears.text) ?? 0,
                                    password: password.text,
                                    phone:
                                        "$selectedCountryCode${phoneNumber.text}",
                                    address: address.text,
                                    level: context
                                            .read<AuthCubit>()
                                            .selectedItem ??
                                        "",
                                  ),
                                );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      const Text(
                        "already have an account ",
                        style: TextStyle(color: Colors.blue),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'sign in',
                            style: TextStyle(
                                decorationThickness: 30, color: Colors.purple),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
