import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_market_app/model/city_search.dart';
import 'package:job_market_app/viewmodel/city_search_viewmodel.dart';


class CityListSortToggleButton extends StatelessWidget {
  late CitySearchViewModel viewModel;

  CityListSortToggleButton({super.key, required this.viewModel});

  TextButton get icon{
    switch(viewModel.mode){
      case CitySearchSortMode.name:
        return TextButton.icon(onPressed: (){viewModel.sortMode = CitySearchSortMode.meanSalary;}, icon: const Icon(Icons.sort_by_alpha), label: Text('Name'));
      case CitySearchSortMode.meanSalary:
        return TextButton.icon(onPressed: (){viewModel.sortMode = CitySearchSortMode.numberOfJobs;}, icon: const Icon(Icons.sort), label: Text('Average Dev Salary'));
      case CitySearchSortMode.numberOfJobs:
        return TextButton.icon(onPressed: (){viewModel.sortMode = CitySearchSortMode.purchasingPower;}, icon: const Icon(Icons.sort), label: Text('Number of Jobs'));
      case CitySearchSortMode.purchasingPower:
        return TextButton.icon(onPressed: (){viewModel.sortMode = CitySearchSortMode.costOfLiving;}, icon: const Icon(Icons.sort), label: Text('Purchasing Power'));
      case CitySearchSortMode.costOfLiving:
        return TextButton.icon(onPressed: (){viewModel.sortMode = CitySearchSortMode.name;}, icon: const Icon(Icons.sort), label: Text('Cost of Living'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return icon;
  }
}