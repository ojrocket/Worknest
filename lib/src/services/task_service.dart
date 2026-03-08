import 'package:flutter/foundation.dart';

class Task {
  final String id;
  String title;
  bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});
}

class TaskService extends ChangeNotifier {
  static final TaskService _instance = TaskService._internal();

  factory TaskService() {
    return _instance;
  }

  TaskService._internal();

  final List<Task> _tasks = [
    Task(id: '1', title: 'Review sprint designs', isCompleted: true),
    Task(id: '2', title: 'Submit quarterly report'),
    Task(id: '3', title: 'Update project documentation'),
    Task(id: '4', title: 'Prepare team presentation', isCompleted: true),
    Task(id: '5', title: 'Schedule 1-on-1 meetings'),
    Task(id: '6', title: 'Code review for PR #142'),
  ];

  List<Task> get tasks => _tasks;

  int get completedCount => _tasks.where((t) => t.isCompleted).length;
  int get totalCount => _tasks.length;
  double get completionPercentage =>
      _tasks.isEmpty ? 0 : completedCount / totalCount;

  void addTask(String title) {
    _tasks.add(Task(id: DateTime.now().toString(), title: title));
    notifyListeners();
  }

  void toggleTask(String id) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void removeTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
