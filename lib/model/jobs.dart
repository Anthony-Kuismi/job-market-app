import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:job_market_app/model/job.dart';

class Jobs {
  late List<Job> jobs = [];

  Jobs();

  Future<void> parseJobs() async {
    WidgetsFlutterBinding.ensureInitialized();
    final csv = await rootBundle.loadString('assets/final_job_list.csv');
    List<List<dynamic>> data = const CsvToListConverter().convert(csv);
    jobs = [];
    for (int i = 1; i < data.length; i++) {
      List<dynamic> row = data[i];

      String title = row[0];
      String company = row[1];
      String location = row[2];
      String type = row[3];
      String description = row[4];
      double salary = row[5];
      String skills = row[6];

      jobs.add(Job(
          title: title,
          company: company,
          location: location,
          type: type,
          description: description,
          salary: salary,
          skillList: skills));
    }
  }

  List<Job> searchByTitle({required String title}) {
    List<Job> matches = [];
    for (Job job in jobs) {
      job.hasTitle(str: title) ? matches.add(job) : '';
    }
    return matches;
  }

  List<Job> searchByCompany({required String company}) {
    List<Job> matches = [];
    for (Job job in jobs) {
      job.hasCompany(str: company) ? matches.add(job) : '';
    }
    return matches;
  }

  List<Job> searchByState({required String stateAbbreviation}) {
    List<Job> matches = [];
    for (Job job in jobs) {
      job.hasState(stateAbbreviation: stateAbbreviation)
          ? matches.add(job)
          : '';
    }
    return matches;
  }

  List<Job> searchByType({required String type}) {
    List<Job> matches = [];
    for (Job job in jobs) {
      job.hasType(str: type) ? matches.add(job) : '';
    }
    return matches;
  }

  List<Job> searchByDescription({required String description}) {
    List<Job> matches = [];
    for (Job job in jobs) {
      job.hasDescription(str: description) ? matches.add(job) : '';
    }
    return matches;
  }

  List<Job> searchBySalary({required double minSalary}) {
    List<Job> matches = [];
    for (Job job in jobs) {
      job.hasSalary(minSalary: minSalary) ? matches.add(job) : '';
    }
    return matches;
  }

  List<Job> searchByRegion({required String region}) {
    List<Job> matches = [];
    for (Job job in jobs) {
      job.hasRegion(str: region) ? matches.add(job) : '';
    }
    return matches;
  }

  List<Job> searchBySkills({required List<String> skills}) {
    List<Job> matches = [];
    for (Job job in jobs) {
      bool match = true;
      for (String skill in skills) {
        if (!job.hasSkill(skill: skill)) {
          match = false;
          break;
        }
      }
      match ? matches.add(job) : '';
    }
    return matches;
  }
}
