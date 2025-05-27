class CreateTaskEntites {
  String? image;
  String? title;
  String? descrption;
  String? priority;
  String? date;
  String? state;

  CreateTaskEntites(
      {this.image,
      this.date,
      this.title,
      this.descrption,
      this.priority,
      this.state});

  // get state => null;

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "title": title,
      "desc": descrption,
      "priority": priority,
      "dueDate": date
    };
  }

  CreateTaskEntites copyWith(
      {String? title,
      String? image,
      String? descrption,
      String? priority,
      String? date}) {
    return CreateTaskEntites(
      title: title ?? this.title,
      image: image ?? this.image,
      descrption: descrption ?? this.descrption,
      priority: priority ?? this.priority,
      date: date ?? this.date,
    );
  }
}
