import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/file_manager.dart';
import '../global/global_data_model.dart';
import '../model/date_time_model.dart';
import '../model/tag_model.dart';
import '../model/task_model.dart';

FileManager fileManager = FileManager();

Future<void> readTasksJson(BuildContext context) async {
  try {
    final String? response = await fileManager.readAsString(
        fileName: "tasks", fileType: "json", folderName: "todo");
    logger.wtf(response);

    final data = await json.decode(response ?? "[]");
    for (var i = 0; i < data.length; i++) {
      logger.w(data[i]);
      TaskModel task = TaskModel.fromJson(data[i]);
      if (task.id != 0 && task.name != "")
        context.read<GlobalData>().tasks.add(task);
    }
    context.read<GlobalData>().isLoadTasks = true;
  } catch (e) {
    logger.e("Error");
    context.read<GlobalData>().isLoadTasks = true;
  }
}

Future<void> readTagsJson(BuildContext context) async {
  try {
    final String? response = await fileManager.readAsString(
        fileName: "tags", fileType: "json", folderName: "todo");
    logger.wtf(response);

    final data = await json.decode(response ?? "[]");
    for (var i = 0; i < data.length; i++) {
      logger.w(data[i]);
      TagModel tag = TagModel.fromJson(data[i]);
      if (tag.id != 0 && tag.name != "")
        context.read<GlobalData>().tags.add(tag);
    }
    context.read<GlobalData>().isLoadTags = true;
  } catch (e) {
    logger.e("Error");
    context.read<GlobalData>().isLoadTags = true;
  }
}

Future<void> writeTasksJson(BuildContext context) async {
  try {
    String data = "[";
    List<TaskModel> tasks =
        Provider.of<GlobalData>(context, listen: false).tasks;
    for (var i = 0; i < tasks.length; i++) {
      var jsonData = tasks[i].toJson();
      var stringData = json.encode(jsonData);
      data += stringData;
      if (i != tasks.length - 1) data += ",";
    }
    data += "]";
    logger.d(data);
    await fileManager.writeAsString(
      fileName: "tasks",
      fileType: "json",
      folderName: "todo",
      data: data,
    );
  } catch (e) {
    logger.e("Error");
  }
}

Future<void> writeTagsJson(BuildContext context) async {
  try {
    String data = "[";
    List<TagModel> tags = Provider.of<GlobalData>(context, listen: false).tags;
    for (var i = 0; i < tags.length; i++) {
      var jsonData = tags[i].toJson();
      var stringData = json.encode(jsonData);
      data += stringData;
      if (i != tags.length - 1) data += ",";
    }
    data += "]";
    logger.d(data);
    await fileManager.writeAsString(
      fileName: "tags",
      fileType: "json",
      folderName: "todo",
      data: data,
    );
  } catch (e) {
    logger.e("Error");
  }
}

String currentDate(DateTime today, DateTimeModel? dateTimeModel) {
  if (dateTimeModel != null) {
    DateTime dateTime = DateTime(
        int.parse(dateTimeModel.date!.split("/")[2]),
        int.parse(dateTimeModel.date!.split("/")[1]),
        int.parse(dateTimeModel.date!.split("/")[0]));
    int daysBetween = dateTime.difference(today).inDays;
    if (daysBetween == 0)
      return "Today";
    else if (daysBetween > 0) {
      if (daysBetween < 31) {
        if (daysBetween == 1)
          return "$daysBetween day after";
        else
          return "$daysBetween days later";
      } else {
        if ((daysBetween / 30).round() == 1)
          return "${(daysBetween / 30).round()} month later";
        else
          return "${(daysBetween / 30).round()} months later";
      }
    } else if (daysBetween < 0) {
      if (daysBetween.abs() < 31) {
        if (daysBetween.abs() == 1)
          return "${daysBetween.abs()} day ago";
        else
          return "${daysBetween.abs()} days ago";
      } else {
        if ((daysBetween.abs() / 30).round() == 1)
          return "${(daysBetween.abs() / 30).round()} month ago";
        else
          return "${(daysBetween.abs() / 30).round()} months ago";
      }
    } else
      return "";
  } else
    return "";
}
