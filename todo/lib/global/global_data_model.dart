import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:todo/model/tag_model.dart';
import 'package:todo/model/task_model.dart';

class GlobalData extends ChangeNotifier {
  int _currentIndex = 1;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

  List<TaskModel> _tasks = [];
  set tasks(List<TaskModel> item) {
    _tasks = item;
    notifyListeners();
  }

  List<TaskModel> get tasks => _tasks;

  void addTasks(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTasks(TaskModel task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void removeAtTasks(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  List<TagModel> _tags = [];
  set tags(List<TagModel> item) {
    _tags = item;
    notifyListeners();
  }

  List<TagModel> get tags => _tags;

  void addTags(TagModel tag) {
    _tags.add(tag);
    notifyListeners();
  }

  void removeTags(TagModel tag) {
    _tags.remove(tag);
    notifyListeners();
  }

  void removeAtTags(int index) {
    _tags.removeAt(index);
    notifyListeners();
  }

  bool _isLoadTasks = false;
  set isLoadTasks(bool isLoadTasks) {
    _isLoadTasks = isLoadTasks;
    notifyListeners();
  }

  bool get isLoadTasks => _isLoadTasks;

  bool _isLoadTags = false;
  set isLoadTags(bool isLoadTags) {
    _isLoadTags = isLoadTags;
    notifyListeners();
  }

  bool get isLoadTags => _isLoadTags;

  DateTime _selectedDate = DateTime.now();
  set selectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime get selectedDate => _selectedDate;

  DateTime _todaysDate = DateTime.now();
  set todaysDate(DateTime todaysDate) {
    _todaysDate = todaysDate;
    notifyListeners();
  }

  DateTime get todaysDate => _todaysDate;

  final Map<int, String> _months = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };
  String get months => _months[_todaysDate.month]?.toUpperCase() ?? "";

  final Map<int, String> _weekdays = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday",
  };
  String get weekdays => _weekdays[_todaysDate.weekday]?.toUpperCase() ?? "";
}

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 8,
    lineLength: 100,
    printTime: true,
  ),
);
