import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getCollections() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
            fromFirestore: (doucSnapshot, _) =>
                TaskModel.fromJson(doucSnapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );

  static Future<void> addTasksToFireStore(TaskModel taskModel) async {
    CollectionReference<TaskModel> taskCollection = getCollections();
    DocumentReference<TaskModel> docRef = taskCollection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> getTasksFromFireStore() async {
    CollectionReference<TaskModel> taskCollection = getCollections();
    QuerySnapshot<TaskModel> querySnapShot = await taskCollection.get();
    return querySnapShot.docs.map((docSnapShot) => docSnapShot.data()).toList();
  }

  static Future<void> deleteTaskFromFireStore(String id) async {
    CollectionReference<TaskModel> taskCollection = getCollections();
    return taskCollection.doc(id).delete();
  }

   static Future<void> updateTaskInFireStore(String id, TaskModel taskModel) async {
    CollectionReference<TaskModel> taskCollection = getCollections();
    return taskCollection.doc(id).update(taskModel.toJson());
  }
}

    /* to add to fireStore
    create collection 
    create document 
    and add you model in func set
     */ 
    ////////
    /* to get from FireStore
    define the collection
    collection.get that return querySnapShot this have list of queryDocument for all database
    you want docs form query to get data 
    you must do .map to convert list of queryDocument to list of model 
     */