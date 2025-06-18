import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';

class StatusDropdown extends StatelessWidget {
  const StatusDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    final selectedState = taskCubit.createTask?.state;

    List<String> items = ["waiting", "inProgress", "finished"];

    return DropdownButtonFormField<String>(
      value: items.contains(selectedState) ? selectedState : null,
      hint: const Text("Select status"),
      decoration: InputDecoration(
        labelText: "Select status",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        taskCubit.createTask?.state = newValue;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please slecet status';
        }
        return null;
      },
    );
  }
}
