import 'package:flutter/cupertino.dart';
import 'package:job_market_app/model/Jobs.dart';

import '../model/job.dart';

class JobSearchViewModel extends ChangeNotifier{
  bool loaded = false;
  Jobs jobs = Jobs();
  String searchType = 'Title';

  JobSearchViewModel();

  setSearchType(newType){
    searchType = newType;
  }

  Future<List<Job>> getSearchResults(query) async {
    if (!loaded) {
      await jobs.parseJobs();
      loaded = true;
    }

    switch (searchType) {
      case 'Title':
        return jobs.searchByTitle(title: query);
      case 'Company':
        return jobs.searchByCompany(company: query);
      case 'State':
        return jobs.searchByState(stateAbbreviation: query);
      case 'Region':
        return jobs.searchByRegion(region: query);
      case 'Position':
        return jobs.searchByType(type: query);
      case 'Description':
        return jobs.searchByDescription(description: query);
      case 'Salary':
        return jobs.searchBySalary(minSalary: double.parse(query));
      case 'Skills':
        query = query.replaceAll(' ', '');
        final skills = query.split(',');
        return jobs.searchBySkills(skills: skills);
      default:
        return jobs.searchByTitle(title: query);
    }
  }
}
