// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/todo/presentation_layer/cubit/todo_cubit.dart';
import '../../../../components/utilities/app_colors.dart';

class DatePick extends StatefulWidget {
  final TextEditingController controller;

  const DatePick({super.key, required this.controller});

  @override
  State<DatePick> createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final existingDate = context.read<TaskCubit>().createTask?.date;
    dateController.text = existingDate ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: Center(
        child: TextField(
          controller: dateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'add due date',
            suffixIcon: Icon(
              Icons.calendar_month,
              color: AppColors.mainColor,
            ),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat("yyyy-MM-dd").format(pickedDate);

              setState(() {
                dateController.text = formattedDate;
              });
              context.read<TaskCubit>().createTask?.date = formattedDate;
            } else {
              print("Not selected");
            }
          },
        ),
      ),
    );
  }
}
