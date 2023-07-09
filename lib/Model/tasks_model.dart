
class TasksModel {
    String? id;
    String? title;
    String? desc;
    bool? completed;

    TasksModel({this.id, this.title, this.desc, this.completed});

    TasksModel.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        title = json["title"];
        desc = json["desc"];
        completed = json["completed"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["title"] = title;
        _data["desc"] = desc;
        _data["completed"] = completed;
        return _data;
    }

    TasksModel copyWith({
        String? id,
        String? title,
        String? desc,
        bool? completed,
    }) => TasksModel(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        completed: completed ?? this.completed,
    );
}