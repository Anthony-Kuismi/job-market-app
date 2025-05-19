import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../model/settings.dart';
import '../service/firestore_service.dart';
import '../view/login.dart';

class SettingsViewModel extends ChangeNotifier {
  final Settings _model = Settings();
  SettingsViewModel(){
    load();
  }

  var firestore = FirestoreService();
  String get linkedIn => _model.linkedIn;

  Future<void> load() async {
    String? linkedIn = await firestore.getUserLinkedIn();
    if (linkedIn.isNotEmpty) {
      _model.linkedIn = linkedIn;
    }
    notifyListeners();
  }
  
  Future<void> setLinkedIn(String url)async {
    _model.linkedIn = url;
    await firestore.setUserLinkedIn(url);
    notifyListeners();
  }

  String getLinkedIn() {
    return _model.linkedIn;
  }


}