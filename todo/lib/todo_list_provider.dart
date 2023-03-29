import 'package:flutter/material.dart';
import 'package:todo/todo_model.dart';

class TodoListProvider with ChangeNotifier {
  List<Todo> items = [];

  void updateItemDescription(Todo item, String description) {
    if (description != null && description != '') {
      item.description = description;
      notifyListeners();
    }
  }

  void removeItem(Todo item) {
    items.remove(item);
    notifyListeners();
  }

  void addNewItem(String description) {
    if (description != null && description != '') {
      items.add(Todo(description));
      notifyListeners();
    }
  }

  void updateItemCompleteness(Todo item) {
    item.complete = !item.complete;
    notifyListeners();
  }
}