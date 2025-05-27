import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';

class StatuDropdown extends StatefulWidget {
  const StatuDropdown({super.key});

  @override
  State<StatuDropdown> createState() => _StatuDropdownState();
}

class _StatuDropdownState extends State<StatuDropdown> {
  List<String> items = ["waiting", "inprogress", "finished"];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
      value: null, // تأكد من أن selectedPriority موجودة في state
      hint: const Text("Select an item"),
      decoration: InputDecoration(
        labelText: " select status", //
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
        context.read<TaskCubit>().createTask?.priority = newValue;
        // context.read<TaskCubit>().selectedLevelPriority(newValue);
      },
    );
  }
}
