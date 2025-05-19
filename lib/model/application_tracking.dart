import '../service/firestore_service.dart';
import 'application.dart';

class ApplicationTracking {
  FirestoreService firestore = FirestoreService();
  List<Application> applications = [];
  Map<String, int>? _id2Idx;


  void updateId2Idx() {
    _id2Idx = {for (int i = 0; i < applications.length; i++) applications[i].id: i};
  }

  get id2idx {
    if (_id2Idx == null) {
      updateId2Idx();
    }
    return _id2Idx;
  }

  Future<void> fetch() async {
    applications = await firestore.getApplicationsFromUser();
  }
}