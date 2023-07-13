class TaskModel {
  String id;
  String description;
  String title;
  bool status;
  int date;
   int time;
String userId;
  TaskModel(
      {this.id = "",
      required this.description,
         required this.userId,
      required this.title,
      required this.status,
         required this.time,

      required this.date});
  TaskModel .fromJson(Map<String,dynamic>json):this(
         id: json["id"],
    description: json["description"],
    title: json["title"],
    status: json["status"],
    date: json["date"],
    userId: json["userId"],
    time: json["time"],

  );
  Map<String,dynamic>toJson(){
    return{
     "id": id,
    "description":  description,
      "title":title,
      "status":status,
     "date" :date,
      "userId" :userId,
      "time":time
    };
  }

}
