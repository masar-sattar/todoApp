// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/profile/presntation/cubit/profile_cubit.dart';
import 'package:todo_app/features/profile/presntation/cubit/profile_state.dart';

import '../widget/field_profile.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    await context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<ProfileCubit, ProfileState>(
    //   builder: (context, state) {
    //     if (state is LoadingProfile) {
    //       return CircularProgressIndicator();
    //     } else if (state is ProfileLoaded) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is LoadingProfile) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            // final user = state.user;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldProfile(
                        labelText: 'NAME', lableTitle: state.user.displayName),

                    // FieldProfile(
                    //   labelText: 'Phone',
                    //   lableTitle: state.user.username,
                    //   trailing: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 300),
                    //     child: Icon(
                    //       Icons.copy,
                    //       color: Colors.deepPurple,
                    //     ),
                    //   ),
                    // ),
                    FieldProfile(
                      labelText: 'PHONE',
                      lableTitle: state.user.username,
                      trailing: IconButton(
                        icon: const Icon(Icons.copy, color: Colors.deepPurple),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: state.user.username));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Phone copied to clipboard')),
                          );
                        },
                      ),
                    ),

                    FieldProfile(
                        labelText: 'LEVEL', lableTitle: state.user.level),

                    FieldProfile(
                        labelText: 'YEARS OF EXPERIENCE',
                        lableTitle: state.user.experienceYears.toString()),

                    FieldProfile(
                        labelText: 'LOCATION', lableTitle: state.user.address)
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
