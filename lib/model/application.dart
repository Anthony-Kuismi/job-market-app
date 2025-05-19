import 'package:uuid/uuid.dart';

class Application {
  String jobTitle;
  String companyName;
  String applicationStage;
  String location;
  double payRate;
  String id;
  DateTime timestamp;

  Application({
    required this.jobTitle,
    required this.companyName,
    required this.applicationStage,
    required this.location,
    required this.payRate,
    required this.id,
    required this.timestamp,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      jobTitle: json['job_title'] ?? '',
      companyName: json['company_name'] ?? '',
      applicationStage: json['application_stage'] ?? '',
      location: json['location'] ?? '',
      payRate: json['pay_rate']?.toDouble() ?? 0.0,
      id: json['id'] ?? const Uuid().v4(),
      timestamp: json['timestamp']!=null? DateTime.fromMillisecondsSinceEpoch(json['timestamp']) : DateTime.now()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_title': jobTitle,
      'company_name': companyName,
      'application_stage': applicationStage,
      'location': location,
      'pay_rate': payRate,
      'id': id,
      'timestamp': timestamp.millisecondsSinceEpoch
    };
  }

  set setJobTitle(newValue) {
    jobTitle = newValue;
  }

  set setCompanyName(newValue) {
    companyName = newValue;
  }

  set setApplicationStage(newValue) {
    applicationStage = newValue;
  }

  set setLocation(newValue) {
    location = newValue;
  }

  set setPayRate(newValue) {
    payRate = newValue;
  }

  String get getJobTitle {
    return jobTitle;
  }

  String get getCompanyName {
    return companyName;
  }

  String get getApplicationStage {
    return applicationStage;
  }

  String get getLocation {
    return location;
  }

  double get getPayRate {
    return payRate;
  }
}