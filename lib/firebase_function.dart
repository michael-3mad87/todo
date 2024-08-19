import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollections() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (doucSnapshot, _) =>
                UserModel.formJson(doucSnapshot.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
          );

  static CollectionReference<TaskModel> getTasksCollections(String userId) =>
      getUsersCollections()
          .doc(userId)
          .collection('tasks')
          .withConverter<TaskModel>(
            fromFirestore: (doucSnapshot, _) =>
                TaskModel.fromJson(doucSnapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );

  static Future<void> addTasksToFireStore(TaskModel taskModel , String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollections(userId);
    DocumentReference<TaskModel> docRef = taskCollection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> getTasksFromFireStore(String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollections(userId);
    QuerySnapshot<TaskModel> querySnapShot = await taskCollection.get();
    return querySnapShot.docs.map((docSnapShot) => docSnapShot.data()).toList();
  }

  static Future<void> deleteTaskFromFireStore(String id , String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollections( userId);
    return taskCollection.doc(id).delete();
  }

  static Future<void> updateTaskInFireStore(
      String id, TaskModel taskModel , String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollections(userId);
    return taskCollection.doc(id).update(taskModel.toJson());
  }

  static Future<UserModel> register(
    String name,
    String password,
    String email,
  ) async {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserModel(
      email: email,
      name: name,
      id: userCredential.user!.uid,
    );
    final userCollection = getUsersCollections();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final userCollection = getUsersCollections();
    final doucSnapshot = await userCollection.doc(credential.user!.uid).get();
    return doucSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
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