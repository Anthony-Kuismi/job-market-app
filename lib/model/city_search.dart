import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'city.dart';

enum CitySearchSortMode{
  name,
  meanSalary,
  costOfLiving,
  numberOfJobs,
  purchasingPower
}

class CitySearch {
  String query = '';
  Map<String,City> data = {};
  CitySearchSortMode mode = CitySearchSortMode.name;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final csv = await rootBundle.loadString('assets/city_data.csv');
    List<List<dynamic>> csvData = const CsvToListConverter().convert(csv);
    csvData.removeAt(0);
    data = {};
    for (var row in csvData) {
      if (row.length >= 9) {

        data[row[1]] = City(
            name: row[7],
            meanSalary: double.tryParse(row[2].toString()) ?? 0.0,
            costOfLiving: double.tryParse(row[10].toString()) ?? 0.0,
            purchasingPower: double.tryParse(row[11].toString()) ?? 0.0,
            numberOfJobs: double.tryParse(row[5].toString()) ?? 0.0
        );
      }
    }
  }


  List<City> get results {
    var out = data.values.where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    switch(mode){
      case CitySearchSortMode.name:
        out.sort((a,b)=>a.name.compareTo(b.name));
        break;
      case CitySearchSortMode.meanSalary:
        out.sort((a,b)=>b.meanSalary.compareTo(a.meanSalary));
        break;
      case CitySearchSortMode.costOfLiving:
        out.sort((a,b)=>a.costOfLiving.compareTo(b.costOfLiving));
        break;
      case CitySearchSortMode.numberOfJobs:
        out.sort((a,b)=>b.numberOfJobs.compareTo(a.numberOfJobs));
        break;
      case CitySearchSortMode.purchasingPower:
        out.sort((a,b)=>b.purchasingPower.compareTo(a.purchasingPower),);
        break;
    }
    return out;
  }

  double get meanSalary => data.isNotEmpty?data.values.fold(0.0, (sum, city) => sum + city.meanSalary) / data.length:0.0;

  double get meanCostOfLiving => data.isNotEmpty?data.values.fold(0.0, (sum, city) => sum + city.costOfLiving) / data.length:0.0;

  double get meanPurchasingPower => data.isNotEmpty?data.values.fold(0.0, (sum, city) => sum + city.purchasingPower) / data.length:0.0;

  double get meanNumberOfJobs => data.isNotEmpty?data.values.fold(0.0, (sum, city) => sum + city.numberOfJobs) / data.length:0.0;

}

