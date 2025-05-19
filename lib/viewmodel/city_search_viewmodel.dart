import 'dart:async';

import 'package:flutter/cupertino.dart';
import '../model/city_search.dart';

class CitySearchViewModel extends ChangeNotifier {
  Timer? _debounce;


  late CitySearch _model;
  CitySearchViewModel(){
    _model = CitySearch();
    _initializeModel();
  }


  Future<void> _initializeModel() async {
    await _model.init();
    notifyListeners();
  }
  get data => _model.data;

  get results => _model.results;

  get citiesCount => _model.data.values.length;

  get resultsCount => _model.results.length;

  set model(CitySearch newValue){
    _model = newValue;
    notifyListeners();
  }

  set sortMode(CitySearchSortMode newValue){
    _model.mode = newValue;
    notifyListeners();
  }
  CitySearchSortMode get mode=>_model.mode;

  set query(String newValue) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _model.query = newValue;
      notifyListeners();
    });
  }
}