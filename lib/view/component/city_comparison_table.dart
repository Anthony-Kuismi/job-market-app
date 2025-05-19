import 'package:flutter/material.dart';
import 'package:job_market_app/viewmodel/city_arena_viewmodel.dart';
import '../../model/city.dart';
import '../../viewmodel/city_search_viewmodel.dart';
import '../city_search_view.dart';

class CityComparisonTable extends StatelessWidget {
  final CityArenaViewModel viewModel;
  final CitySearchViewModel citySearchViewModel;

  final String username;

  const CityComparisonTable(
      {super.key,
      required this.username,
      required this.citySearchViewModel,
      required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: DataTable(
      columns: [
        DataColumn(
            label: Row(children: [
          TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitySearchView(
                            username: username,
                            title: 'Select City A',
                            currentPage: 'CityArenaView',
                            callback: (city) {
                              viewModel.cityA = city;
                              Navigator.pop(context);
                            })));
              },
              icon: const Icon(Icons.edit_location_alt_outlined),
              label: Text(
                viewModel.cityA?.name ?? "City A",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ])),
        DataColumn(
            label: Row(children: [
          TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitySearchView(
                            username: username,
                            title: 'Select City B',
                            currentPage: 'CityArenaView',
                            callback: (city) {
                              viewModel.cityB = city;
                              Navigator.pop(context);
                            })));
              },
              icon: const Icon(Icons.edit_location_alt_outlined),
              label: Text(
                viewModel.cityB?.name ?? "City B",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ])),
      ],
      rows: _buildRows(context),
    ));
  }

  List<DataRow> _buildRows(BuildContext context) {
    return [
      DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return Theme.of(context).colorScheme.primary.withOpacity(0.2);
        }),
        cells: [
          DataCell(Text(
            'Higher Mean Salary:',
          )),
          DataCell(Text(viewModel.meanSalaryVictor?.name ?? '--')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${viewModel.cityA?.nameNoState ?? ''}'),
              Text(
                '${viewModel.cityA?.meanSalary ?? '--'}',
                style: TextStyle(
                  color: (viewModel.cityA != null ||
                          viewModel.meanSalaryVictor != null)
                      ? (viewModel.meanSalaryVictor?.name ==
                              viewModel.cityA?.name
                          ? Colors.green
                          : Colors.red)
                      : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
          DataCell(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${viewModel.cityB?.nameNoState ?? ''}'),
              Text(
                '${viewModel.cityB?.meanSalary ?? '--'}',
                style: TextStyle(
                  color: (viewModel.cityB != null ||
                          viewModel.meanSalaryVictor != null)
                      ? (viewModel.meanSalaryVictor?.name ==
                              viewModel.cityB?.name
                          ? Colors.green
                          : Colors.red)
                      : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
        ],
      ),
      DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return Theme.of(context).colorScheme.primary.withOpacity(0.2);
        }),
        cells: [
          DataCell(Text(
            'Lower Cost of Living:',
          )),
          DataCell(Text(
            viewModel.costOfLivingVictor?.name ?? '--',
            textAlign: TextAlign.center,
          ))
        ],
      ),
      DataRow(
        cells: [
          DataCell(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${viewModel.cityA?.nameNoState ?? ''}',textAlign: TextAlign.center,),
              Text(
                '${viewModel.cityA?.costOfLiving ?? '--'}',
                style: TextStyle(
                  color: (viewModel.cityA != null ||
                          viewModel.costOfLivingVictor != null)
                      ? (viewModel.costOfLivingVictor?.name ==
                              viewModel.cityA?.name
                          ? Colors.green
                          : Colors.red)
                      : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
          DataCell(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${viewModel.cityB?.nameNoState ?? ''}'),
              Text(
                '${viewModel.cityB?.costOfLiving ?? '--'}',
                style: TextStyle(
                  color: (viewModel.cityB != null ||
                          viewModel.costOfLivingVictor != null)
                      ? (viewModel.costOfLivingVictor?.name ==
                              viewModel.cityB?.name
                          ? Colors.green
                          : Colors.red)
                      : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
        ],
      ),
      DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return Theme.of(context).colorScheme.primary.withOpacity(0.2);
        }),
        cells: [
          DataCell(Text(
            'Greater Purchasing Power:',
          )),
          DataCell(Text(viewModel.purchasingPowerVictor?.name ?? '--'))
        ],
      ),
      DataRow(
        cells: [
          DataCell(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${viewModel.cityA?.nameNoState ?? ''}'),
              Text(
                '${viewModel.cityA?.purchasingPower ?? '--'}',
                style: TextStyle(
                  color: (viewModel.cityA != null ||
                          viewModel.purchasingPowerVictor != null)
                      ? (viewModel.purchasingPowerVictor?.name ==
                              viewModel.cityA?.name
                          ? Colors.green
                          : Colors.red)
                      : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
          DataCell(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${viewModel.cityB?.nameNoState ?? ''}'),
              Text(
                '${viewModel.cityB?.purchasingPower ?? '--'}',
                style: TextStyle(
                  color: (viewModel.cityB != null ||
                          viewModel.purchasingPowerVictor != null)
                      ? (viewModel.purchasingPowerVictor?.name ==
                              viewModel.cityB?.name
                          ? Colors.green
                          : Colors.red)
                      : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
        ],
      ),
      DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return Theme.of(context).colorScheme.primary.withOpacity(0.2);
        }),
        cells: [
          DataCell(Text(
            'More Developer Jobs:',
          )),
          DataCell(Text(viewModel.numberOfJobsVictor?.name ?? '--'))
        ],
      ),
      DataRow(
        cells: [
          DataCell(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${viewModel.cityA?.nameNoState ?? ''}'),
              Text(
                '${viewModel.cityA?.numberOfJobs ?? '--'}',
                style: TextStyle(
                  color: (viewModel.cityA != null ||
                          viewModel.numberOfJobsVictor != null)
                      ? (viewModel.numberOfJobsVictor?.name ==
                              viewModel.cityA?.name
                          ? Colors.green
                          : Colors.red)
                      : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
          DataCell(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${viewModel.cityB?.nameNoState ?? ''}'),
              Text(
                '${viewModel.cityB?.numberOfJobs ?? '--'}',
                style: TextStyle(
                  color: (viewModel.cityB != null ||
                          viewModel.numberOfJobsVictor != null)
                      ? (viewModel.numberOfJobsVictor?.name ==
                              viewModel.cityB?.name
                          ? Colors.green
                          : Colors.red)
                      : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
        ],
      ),
    ];
  }
}
