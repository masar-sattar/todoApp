class CreateTaskEntites {

  String image;
  String title;
  String descrption;
  String priority;
  String date;

  CreateTaskEntites({
  required this.image,
  required this.date,
  required this.title,
  required this.descrption,
  required this.priority,

  });

  Map<String, dynamic> toJson() {
  return {
    "image":image,
    "title": title,
    "desc":descrption,
    "priority":priority,
    "dueDate":date
  };
  }
  }

