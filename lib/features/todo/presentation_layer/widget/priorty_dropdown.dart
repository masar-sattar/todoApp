//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/todo_cubit.dart';
//
// class PriorityDropdown extends StatelessWidget {
//   const PriorityDropdown({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       value: context.read<TaskCubit>().state.selectedPriority, // تأكد من أن selectedPriority موجودة في state
//       hint: const Text("Select an item"),
//       decoration: InputDecoration(
//         labelText: "Priority Level", //
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       items: context.read<TaskCubit>().state.items.map((String item) {
//         return DropdownMenuItem(
//           value: item,
//           child: Text(item),
//         );
//       }).toList(),
//       onChanged: (String? newValue) {
//
//         context.read<TaskCubit>().selectedLevelPriority(newValue);
//       },
//     );
//   }
// }
