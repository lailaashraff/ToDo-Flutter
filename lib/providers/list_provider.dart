import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../models/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskList = [];

  DateTime selectedDate = DateTime.now();

  void getTasksFromFireStore() async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTaskCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    ///filter based on date
    taskList = taskList.where((task) {
      if (task.dateTime?.day == selectedDate.day &&
          task.dateTime?.month == selectedDate.month &&
          task.dateTime?.year == selectedDate.year) {
        return true;
      }
      return false;
    }).toList();
    taskList.sort(
      (task1, task2) {
        return task1.dateTime!.compareTo(task2.dateTime!);
      },
    );

    notifyListeners();
  }

  void changeSelectDate(DateTime newDate) {
    selectedDate = newDate;
    getTasksFromFireStore();
  }
}
