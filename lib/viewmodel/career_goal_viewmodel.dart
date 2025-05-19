import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:job_market_app/service/firestore_service.dart';
import '../model/career_goal.dart';


class CareerGoalViewModel extends ChangeNotifier{

  List<Goal> _goals = [];
  var firestore = FirestoreService();

  List<Goal> get goals => _goals;

  CareerGoalViewModel(){
    init();
  }

  Future<void> init() async{
    _goals=await firestore.getGoalsFromFirestore();
    
    notifyListeners();
  }

  Future<void>? addGoals(Goal goalToBeAdded) async{
      goals.add(goalToBeAdded);
      await firestore.addGoalsToFirestore(goalToBeAdded);
      notifyListeners();
  }
   Future<void> removeGoal(Goal oldGoal) async {
     int index = _goals.indexWhere((goal) => goal.id == oldGoal.id);
     if (index != -1) {
       _goals.removeAt(index);
       await firestore.removeGoalFromFirestore(oldGoal);
       notifyListeners();
     }
   }

  Future<void> updateGoal(Goal goal) async {
    await firestore.addGoalsToFirestore(goal);
    notifyListeners();
  }
}
