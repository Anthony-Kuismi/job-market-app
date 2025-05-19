import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileSettingsViewModel extends ChangeNotifier {
  late String _firstName;
  late String _lastName;
  late String _gender;
  late String _birthDate;

  ProfileSettingsViewModel() {
    
    _firstName = '';
    _lastName = '';
    _gender = '';
    _birthDate = '';
  }

  
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get gender => _gender;
  String get birthDate => _birthDate;

  
  void setFirstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }


  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  void setBirthDate(String birthDate) {
    _birthDate = birthDate;
    notifyListeners();
  }

}