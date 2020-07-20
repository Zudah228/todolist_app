class Task {
  int id;
  int status;
  String title;
  DateTime addedDate;
  DateTime completedDate;

  Task({this.id, this.status, this.title, this.addedDate, this.completedDate});

//  factory Task.fromMap(Map<String, dynamic> json) => Task(
//    id: json["id"],
//    status: json["status"],
//    title: json["title"],
//    addedDate: DateTime.parse(json["addedDate"]).toLocal(),
//    completedDate: DateTime.parse(json["completedDate"]).toLocal(),
//  );

//  Map<String, dynamic> toMap() => {
//    "id": id,
//    "status": status,
//    "title": title,
//    "addedDate": addedDate.toUtc().toIso8601String(),
//    "comletedDate": completedDate.toUtc().toIso8601String(),
//  };



}