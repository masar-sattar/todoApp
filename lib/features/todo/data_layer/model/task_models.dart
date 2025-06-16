class TaskModel {
  String id;
  String image;
  String title;
  String description;
  String priority;
  String date;
  String state; // <-- الحالة الجديدة: All, In Progress, Waiting, Finished

  TaskModel({
    required this.id,
    required this.image,
    required this.date,
    required this.title,
    required this.description,
    required this.priority,
    required this.state, // <-- أضفها هنا
  });

  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> data = {
  //     "image": image,
  //     "title": title,
  //     "desc": description,
  //     "priority": priority,
  //     "dueDate": date,
  //     "status": state,
  //   };
  //   // return {
  //   //   "image": image,
  //   //   "title": title,
  //   //   "desc": description,
  //   //   "priority": priority,
  //   //   "dueDate": date,
  //   //   "status": state, // <-- وأضفها هنا أيضاً
  //   // };
  //   if (image.isEmpty) {
  //     data.remove("image");
  //   }

  //   return data;
  // }
  Map<String, dynamic> toJson({bool isEdit = false}) {
    Map<String, dynamic> data = {
      "image": isEdit
          ? image
          : image.replaceFirst("https://todo.iraqsapp.com/images/", ""),
      "title": title,
      "desc": description,
      "priority": priority,
      "dueDate": date,
      "status": state,
    };

    if (data["image"]!.isEmpty) {
      data.remove("image");
    }

    return data;
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      image: "https://todo.iraqsapp.com/images/${json['image']}",
      // image: json['image'],
      title: json['title'] ?? '',
      description: json['desc'] ?? '',
      priority: json['priority'] ?? '',
      date: json['updatedAt'] ?? '',
      state: json['status'] ?? 'all', // <-- قيمة افتراضية إن لم توجد
    );
  }
}
