
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../components/utilities/app_colors.dart';

class DatePick extends StatefulWidget {
  const DatePick({super.key});

  @override
  State<DatePick> createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  TextEditingController dateController=TextEditingController();

  @override
  void initState(){
    super.initState();
    dateController.text="";
  }
   @override
  Widget build(BuildContext context) {
    return Container(


padding: const EdgeInsets.symmetric(vertical: 20,horizontal:8),
child: Center(child: TextField(
controller: dateController,

decoration:
InputDecoration(
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
  ),
  hintText: 'add due date',
  suffixIcon: Icon(Icons.calendar_month,color:AppColors.mainColor,),

),
readOnly: true,
onTap: () async{
DateTime? pickedDate=await showDatePicker(context: context,
initialDate: DateTime.now(),
firstDate: DateTime(2000),
lastDate: DateTime(2101),
);
if(pickedDate!=null){
String formattedDate=DateFormat("yyyy-MM-dd").format(pickedDate);

setState(() {
dateController.text=formattedDate.toString();
});
}else{
print("Not selected");
}
},
),),
);
   }
}