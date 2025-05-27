import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';

class PriorityDropdown extends StatefulWidget {
  final bool isEdit;
  const PriorityDropdown({super.key, required this.isEdit});

  @override
  State<PriorityDropdown> createState() => _PriorityDropdownState();
}

class _PriorityDropdownState extends State<PriorityDropdown> {
  List<String> items = ["high", "medium", "low"];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
      value: widget.isEdit
          ? context.read<TaskCubit>().createTask!.priority
          : null, // تأكد من أن selectedPriority موجودة في state
      hint: const Text("Select an item"),
      decoration: InputDecoration(
        labelText: "Priority Level", //
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
