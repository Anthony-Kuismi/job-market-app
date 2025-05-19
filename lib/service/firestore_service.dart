import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/application.dart';
import '../model/career_goal.dart';

class FirestoreService {
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> addGoalsToFirestore(Goal goal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userId');
    final userRef =
        FirebaseFirestore.instance.collection('users/$username/Goals');
    userRef.doc(goal.id).set({
      'goalTextString': goal.goalTextString,
      'isLongTerm': goal.isLongTerm,
      'isChecked': goal.isChecked,
      'id': goal.id
    });
  }

  Future<void> removeGoalFromFirestore(Goal goal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userId');
    final userRef =
        FirebaseFirestore.instance.collection('users/$username/Goals');
    userRef.doc(goal.id).delete();
  }

  Future<List<Goal>> getGoalsFromFirestore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userId');
    final goalEntries =
        FirebaseFirestore.instance.collection('users/$username/Goals');
    final snapshot = await goalEntries.get();
    List<Goal> goals = snapshot.docs
        .map((doc) => Goal(
              goalTextString: doc['goalTextString'],
              isLongTerm: doc['isLongTerm'],
              isChecked: doc['isChecked'],
              id: doc['id'],
            ))
        .toList();
    return goals;
  }

  Future<void> addApplicationToUser(Application item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userId');
    final userRef = FirebaseFirestore.instance
        .collection('users/$username/Application Tracking');
    userRef.doc(item.id).set(item.toJson());
  }

  Future<List<Application>> getApplicationsFromUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userId');
    final applicationEntries = FirebaseFirestore.instance
        .collection('users/$username/Application Tracking');
    final snapshot = await applicationEntries.get();
    List<Application> applications =
        snapshot.docs.map((doc) => Application.fromJson(doc.data())).toList();

    return applications;
  }

  Future<void> deleteApplicationFromUser(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userId');
    final applicationEntries = FirebaseFirestore.instance
        .collection('users/$username/Application Tracking');
    applicationEntries.doc(id).delete();
  }

  Future<void> updateApplicationStatus(String id, String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userId');
    final applicationEntries = FirebaseFirestore.instance
        .collection('users/$username/Application Tracking');
    applicationEntries.doc(id).update({'applicationStage': status});
  }

  Future<void> setUserLinkedIn(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userId');
    final userRef = FirebaseFirestore.instance.collection('users');
    userRef.doc('$username').update({'LinkedIn': url});
  }

  Future<String> getUserLinkedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userId');
    log('$username');
    final userRef = FirebaseFirestore.instance.collection('users');
    log('$userRef');
    final userDoc = await userRef.doc('$username').get();
    log('${userDoc.data()}');
    print('user linkedin: ${userDoc.data()!['LinkedIn']}');
    return userDoc.data()?['LinkedIn']??'';
  }
}
