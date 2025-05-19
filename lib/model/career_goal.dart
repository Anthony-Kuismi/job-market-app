import 'package:uuid/uuid.dart';

class Goal{
  String goalTextString;
  bool isLongTerm;
  bool isChecked;
  final String id;
  Goal({required this.goalTextString, required this.isLongTerm, required this.isChecked,String? id}):id=id??const Uuid().v4();
}
