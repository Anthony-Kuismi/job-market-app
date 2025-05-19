import '../service/firestore_service.dart';

class Settings {
  String linkedIn = '';

  FirestoreService firestore = FirestoreService();


  Future<void> fetchSettings() async {
    linkedIn = await firestore.getUserLinkedIn();
  }
}