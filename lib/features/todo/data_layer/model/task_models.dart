// class TaskModel {
//   String image;
//   String title;
//   String description;
//   String priority;
//   String date;
//
//
//   TaskModel({
//     required this.image,
//     required this.date,
//     required this.title,
//     required this.description,
//     required this.priority,
//
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "image":image,
//       "title": title,
//       "desc":description,
//       "priority":priority,
//       "dueDate":date
//     };
//   }
// }
class TaskModel {
  String image;
  String title;
  String description;
  String priority;
  String date;
  String state; // <-- الحالة الجديدة: All, In Progress, Waiting, Finished

  TaskModel({
    required this.image,
    required this.date,
    required this.title,
    required this.description,
    required this.priority,
    required this.state, // <-- أضفها هنا
  });

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "title": title,
      "desc": description,
      "priority": priority,
      "dueDate": date,
      "state": state, // <-- وأضفها هنا أيضاً
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      description: json['desc'] ?? '',
      priority: json['priority'] ?? '',
      date: json['dueDate'] ?? '',
      state: json['state'] ?? 'all', // <-- قيمة افتراضية إن لم توجد
    );
  }
}
