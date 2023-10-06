import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/my_user.dart';
import 'package:todo/models/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uid) {
    return getUserCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFirestore(snapshot.data()!),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFirestore(Task task, String uid) {
    var taskCollection = getTaskCollection(uid);
    var docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> updateTaskInFirestore(Task task, String uid) async {
    try {
      // Get the Firestore document reference for the task using its ID
      DocumentReference<Task> taskRef =
          FirebaseUtils.getTaskCollection(uid).doc(task.id);

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

  static Future<void> deleteTask(Task task, String uid) {
    return getTaskCollection(uid).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFirestore(snapshot.data()),
            toFirestore: (user, options) => user.toFirestore());
  }

  static Future<void> addUserToFirestore(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserData(String uid) async {
    var querySnapshot = await getUserCollection().doc(uid).get();
    return querySnapshot.data();
  }
}
