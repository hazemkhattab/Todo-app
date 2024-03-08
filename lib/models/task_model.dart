class TaskModel {
  String? id;
  String title;
  String description;
  bool isDone;
  DateTime dateTime;

  TaskModel(
      {this.id,
      required this.title,
      required this.description,
      required this.isDone,
      required this.dateTime});

  factory TaskModel.fromFireStore(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isDone: json["isDone"],
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          json["dateTime"],
        ),
      );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone,
      "dateTime": dateTime.millisecondsSinceEpoch,
    };
  }
}
