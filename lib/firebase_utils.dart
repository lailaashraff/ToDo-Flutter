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

  static Future<void> deleteTask(Task task) {
    return getTaskCollection().doc(task.id).delete();
  }
}
