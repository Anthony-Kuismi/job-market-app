import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/city.dart';
import '../model/city_arena.dart';

class CityArenaViewModel extends ChangeNotifier {
  final CityArena _model = CityArena();
  City? get cityA => _model.city1;
  City? get cityB => _model.city2;
  int get selectedTab => _model.selectedTab;


  City? get meanSalaryVictor => (cityA!=null&&cityB!=null&&cityA!.meanSalary!=cityB!.meanSalary)?((cityA!.meanSalary>cityB!.meanSalary)?cityA:cityB):null;
  City? get numberOfJobsVictor => (cityA!=null&&cityB!=null&&cityA!.numberOfJobs!=cityB!.numberOfJobs)?((cityA!.numberOfJobs>cityB!.numberOfJobs)?cityA:cityB):null;
  City? get costOfLivingVictor => (cityA!=null&&cityB!=null&&cityA!.costOfLiving!=cityB!.costOfLiving)?((cityA!.costOfLiving<cityB!.costOfLiving)?cityA:cityB):null;
  City? get purchasingPowerVictor => (cityA!=null&&cityB!=null&&cityA!.purchasingPower!=cityB!.purchasingPower)?((cityA!.purchasingPower>cityB!.purchasingPower)?cityA:cityB):null;

  set cityA(City? newValue){
    _model.city1 = newValue;
    log('UPDATED CITY 1 to ${cityA!.name}');

    notifyListeners();
  }
  set cityB(City? newValue){
    _model.city2 = newValue;
    log('UPDATED CITY 2 to ${cityB!.name}');
    notifyListeners();
  }
  set selectedTab(int newValue){
    _model.selectedTab = newValue;
    notifyListeners();
  }
  void changeTab(int newValue){
    selectedTab = newValue;
  }

  setCity(selectedCity) {
    if(selectedTab==0){
      cityA = selectedCity;
    }else{
      cityB = selectedCity;
      log('UPDATED CITY 2 to ${cityB!.name}');

    }
    notifyListeners();
  }
}