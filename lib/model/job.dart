class Job {
  String title;
  String company;
  String location;
  String type;
  String description;
  double salary;
  List<String> skills = [];

  final midwestStates = [
    'ND',
    'SD',
    'NE',
    'KS',
    'MN',
    'IA',
    'MO',
    'WI',
    'IL',
    'IN',
    'MI',
    'OH'
  ];

  final westStates = [
    'WA',
    'OR',
    'CA',
    'ID',
    'NV',
    'MT',
    'UT',
    'AZ',
    'WY',
    'CO',
    'NM'
  ];

  final southStates = [
    'TX',
    'OK',
    'AR',
    'LA',
    'KY',
    'TN',
    'MS',
    'AL',
    'FL',
    'GA',
    'SC',
    'NC',
    'VA',
    'WV',
    'MD',
    'DE'
  ];

  final northEastStates = [
    'PA',
    'NY',
    'NJ',
    'CT',
    'MA',
    'RI',
    'VT',
    'NH',
    'ME'
  ];

  final pacificStates = ['AK', 'HI'];

  Job(
      {required this.title,
      required this.company,
      required this.location,
      required this.type,
      required this.description,
      required this.salary,
      required String skillList}) {
    String skill = '';
    for (int i = 1; i < skillList.length - 1; i++) {
      final c = skillList[i];
      if (c == '\'' && skill.isNotEmpty) {
        skills.add(skill.toLowerCase());
        skill = '';
      }
      if (c != '\'' && c != ',' && c != ' ') {
        skill += c;
      }
    }
  }

  String getSkillsAsString() {
    if (skills.isEmpty) {
      return 'None.';
    }
    String string = '';
    for (String skill in skills) {
      string += skill;
      string += ', ';
    }
    return '${string.substring(0, string.length - 2)}.';
  }

  
  bool hasSkill({required String skill}) {
    return skills.contains(skill.toLowerCase());
  }

  
  bool hasTitle({required String str}) {
    return title.toLowerCase().contains(str.toLowerCase());
  }

  
  bool hasCompany({required String str}) {
    return company.toLowerCase().contains(str.toLowerCase());
  }

  
  bool hasType({required String str}) {
    return type.toLowerCase().contains(str.toLowerCase());
  }

  
  bool hasDescription({required String str}) {
    return description.toLowerCase().contains(str.toLowerCase());
  }

  
  bool hasSalary({required double minSalary}) {
    return salary >= minSalary;
  }

  
  bool hasState({required String stateAbbreviation}) {
    if (location == 'Remote') {
      return true;
    }
    return stateAbbreviation.toLowerCase() == location.toLowerCase();
  }

  
  bool hasRegion({required String str}) {
    if (location == 'Remote') {
      return true;
    }

    str = str.toLowerCase();

    switch (str) {
      case 'midwest':
        return midwestStates.contains(location);
      case 'west':
        return westStates.contains(location);
      case 'northeast':
        return northEastStates.contains(location);
      case 'south':
        return southStates.contains(location);
      case 'pacific':
        return pacificStates.contains(location);
      default:
        return false;
    }
  }
}
