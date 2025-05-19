class City {
  double meanSalary;
  double costOfLiving;
  double purchasingPower;
  double numberOfJobs;

  String name;
  String get nameNoState => name.replaceAll(RegExp(r',\s[A-Z][A-Z]'), '');
  // String get nameNoState => name.replaceAll(',', replace)
  City({required this.name, required this.meanSalary,required this.costOfLiving, required this.purchasingPower, required this.numberOfJobs});
}
