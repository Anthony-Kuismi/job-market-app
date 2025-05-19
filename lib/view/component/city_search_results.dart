import 'dart:developer';

import 'package:flutter/material.dart';

import '../../model/city.dart';
import '../../viewmodel/city_search_viewmodel.dart';

class CitySearchResults extends StatelessWidget {
  CitySearchViewModel viewModel;
  final Function(City)? callback;


  CitySearchResults({required this.viewModel, this.callback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: viewModel.resultsCount,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          return CityContainer(city: viewModel.results[index],callback: callback,);
        },
      ),
    );
  }
}

class CityContainer extends StatelessWidget {
  City city;
  final Function(City)? callback;

  CityContainer({required this.city, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback!(city);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              city.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            SizedBox(height: 8), 
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1), 
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                    children: [
                      const Text('Average Developer Salary:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('\$${city.meanSalary.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                    ]
                ),
                TableRow(
                    children: [
                      const Text('Average Cost of Living:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('\$${city.costOfLiving.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                    ]
                ),
                TableRow(
                    children: [
                      const Text('Purchasing Power Index:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${city.purchasingPower.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                    ]
                ),
                TableRow(
                    children: [
                      const Text('Developer Jobs:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${city.numberOfJobs}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                    ]
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

