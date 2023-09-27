import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFirestore(snapshot.data()!),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFirestore(Task task) {
    var taskCollection = getTaskCollection();
    var docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  // static Future<void> updateTaskToFirestore(Task task) {
  //   var taskCollection = getTaskCollection();
  //   var docRef = taskCollection.doc();
  //   task.id = docRef.id;
  //   return docRef.update({
  //     'title': task.title,
  //     'description': task.description,
  //     'dateTime': task.dateTime?.millisecondsSinceEpoch,
  //   });
  // }
  static Future<void> updateTaskInFirestore(Task task) async {
    try {
      // Get the Firestore document reference for the task using its ID
      DocumentReference<Task> taskRef =
          FirebaseUtils.getTaskCollection().doc(task.id);

      // Update the task details in Firestore
      await taskRef.update({
        'title': task.title,
        'description': task.description,
        'dateTime': task.dateTime?.millisecondsSinceEpoch,
      });

      print('Task updated successfully in Firestore');
    } catch (e) {
      print('Error updating task in Firestore: $e');
      // Handle the error as needed
    }
  }

  // Future<void> updateTask(Task task) {
  //   return FirebaseUtils.getTaskCollection()
  //       .doc(task.id)
  //       .update();
  // }
  static Future<void> deleteTask(Task task) {
    return getTaskCollection().doc(task.id).delete();
  }
}
