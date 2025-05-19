import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../model/application.dart';
import '../model/application_tracking.dart';
import '../service/firestore_service.dart';
import '../service/navigator_service.dart';

class ApplicationTrackingViewModel extends ChangeNotifier {
  late final NavigatorService navigatorService;

  ApplicationTrackingViewModel(this.navigatorService);

  final ApplicationTracking _model = ApplicationTracking();

  List<Application> get applications => _model.applications;

  var firestore = FirestoreService();

  List<Application> readyToApply() {
    return _model.applications.where((element) => element.applicationStage == 'Ready to Apply').toList();
  }

  List<Application> applied() {
    print(_model.applications.where((element) => element.applicationStage == 'Applied').toList());
    return _model.applications.where((element) => element.applicationStage == 'Applied').toList();
  }

  List<Application> interviewing() {
    return _model.applications.where((element) => element.applicationStage == 'Interviewing').toList();
  }

  List<Application> offer() {
    return _model.applications.where((element) => element.applicationStage == 'Received Offer').toList();
  }

  Future<void> load() async {
    await _model.fetch();
    _model.updateId2Idx();
    notifyListeners();
  }

  update() {
    _model.fetch();
    _model.updateId2Idx();
  }

  void addApplication(String jobTitle, String companyName, String location, double payRate, String applicationStage, DateTime timestamp) async {
    Application newApplication = Application(jobTitle: jobTitle, companyName: companyName, location: location, payRate: payRate, applicationStage: applicationStage, id: const Uuid().v4(), timestamp: timestamp);
    _model.applications.add(newApplication);
    _model.updateId2Idx();
    await firestore.addApplicationToUser(newApplication);
    await load();
    notifyListeners();
  }

  void deleteApplication(String id) async {
    _model.applications.removeAt(_model.id2idx[id]!);
    _model.updateId2Idx();
    await firestore.deleteApplicationFromUser(id);
    notifyListeners();
  }

  void updateApplicationStatus(String id, String status) async {
    _model.applications[_model.id2idx[id]!].applicationStage = status;
    await firestore.updateApplicationStatus(id, status);
    notifyListeners();
  }

}