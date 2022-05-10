import 'date_time_model.dart';
import 'tag_model.dart';

class TaskModel {
  int? id;
  String? name;
  bool? completed;
  TagModel? tag;
  DateTimeModel? dateTime;

  TaskModel(
      {this.id = 0,
      this.name = "",
      this.completed = false,
      this.tag,
      this.dateTime});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    completed = json['completed'] ?? false;
    tag = json['tag'] != null ? TagModel.fromJson(json['tag']) : null;
    dateTime = json['dateTime'] != null
        ? DateTimeModel.fromJson(json['dateTime'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['completed'] = this.completed;
    this.tag != null
        ? data['tag'] = this.tag?.toJson()
        : data['tag'] = TagModel().toJson();
    this.dateTime != null
        ? data['dateTime'] = this.dateTime?.toJson()
        : data['dateTime'] = DateTimeModel().toJson();
    return data;
  }
}
