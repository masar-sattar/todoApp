import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';

class LevelDropdown extends StatelessWidget {
  const LevelDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          value: context.read<AuthCubit>().selectedItem,
          hint: const Text("Select an item"),
          decoration: InputDecoration(
            labelText: "level",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: context.read<AuthCubit>().items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            context.read<AuthCubit>().selectLevelExperience(newValue);
          },
        );
      },
    );
  }
}
